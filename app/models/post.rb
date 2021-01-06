# frozen_string_literal: true

require "feed_processing/titles"

# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  excerpt       :text
#  published_at  :datetime
#  thumbnail_url :string
#  title         :string
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  feed_id       :integer
#  source_id     :integer
#
# Indexes
#
#  index_posts_on_published_at  (published_at)
#  index_posts_on_source_id     (source_id)
#
class Post < ApplicationRecord
  include Bookmarkable
  include Favoritable

  belongs_to :source
  belongs_to :feed, optional: true
  has_many :post_actions

  def import_thumbnail!(url = nil)
    if url.nil?
      # TODO: grab image from article's Open Graph
    end

    update(thumbnail_url: url)
  end

  def absolute_thumbnail_url
    # TODO: this might not be what's needed, but it's a workable hack for now

    if thumbnail_url.to_s.start_with? "/"
      begin
        URI.parse(url.strip).merge(thumbnail_url.strip)
      rescue StandardError
        "" # TODO: returning a blank string instead of image URL isn't ideal
      end
    else
      thumbnail_url.strip
    end
  end

  def has_real_title?
    title.present? && !(title == url || title =~ %r!^https?://!)
  end

  def list_title
    processor = FeedProcessing::Titles.new

    if has_real_title?
      processor.list(title)
    else
      processor.list(excerpt, process_excerpt: true)
    end
  end

  def qualified_url
    if url.match? %r!^http!
      url
    else
      if url.match? %r!^/!
        source.url.sub(%r!/$!, "") + url
      else
        # something weird going on
        source.url
      end
    end
  end
end
