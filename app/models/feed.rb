# frozen_string_literal: true

require "feedbag"

# == Schema Information
#
# Table name: feeds
#
#  id               :bigint           not null, primary key
#  active           :boolean
#  bad_summary      :boolean
#  last_checked_at  :datetime
#  no_thumbnails    :boolean
#  review_requested :boolean          default(FALSE)
#  url              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  publication_id   :integer
#
class Feed < ApplicationRecord
  belongs_to :publication, optional: true
  has_many :posts
  scope :active, -> { where active: true }

  validates :url, uniqueness: true

  delegate :import!, to: :importer

  def self.autodiscover_and_add_from_url(url)
    return add_feed_from_url(url) if Feedbag.feed?(url)
    return find_by_url(url) if where(url: url).count.positive?

    feeds = Feedbag.find(url)

    add_feed_from_url(feeds.first) if feeds.present?
  end

  # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
  def self.add_feed_from_url(url)
    return find_by_url(url) if where(url: url).count.positive?

    conn = Faraday.new do |f|
      f.use FaradayMiddleware::FollowRedirects, limit: 3
      f.adapter Faraday.default_adapter
    end
    feed_data = Feedjira.parse(conn.get(url).body)
    raise "No title" unless feed_data.title.present?

    feed = Feed.create(url: url, active: true)

    publication = Publication.create(
      title: feed_data.title,
      url: feed_data.url,
      description: feed_data.description,
      handle: Publication.generate_private_handle,
      hide_from_public: true
    )
    publication.import_icon!

    feed.update(publication: publication)
    feed.import!

    feed
  rescue FaradayMiddleware::RedirectLimitReached
    Rails.logger.warn "*** ERROR: redirect limit reached, unable to parse #{url}"
  rescue StandardError => e
    Rails.logger.warn "*** ERROR: unable to parse #{url}: #{e.message}"
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def importer = @importer ||= Importers::FeedImporter.new(self)
end
