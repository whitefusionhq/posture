# frozen_string_literal: true

# == Schema Information
#
# Table name: sources
#
#  id                 :bigint           not null, primary key
#  description        :text
#  handle             :string
#  hide_from_public   :boolean          default(FALSE)
#  latest_post_at     :datetime
#  title              :string
#  twitter_handle     :string
#  type               :string           default("Publication")
#  url                :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  icon_cloudinary_id :string
#
# Indexes
#
#  index_sources_on_type  (type)
#
class Source < ApplicationRecord
  include Subscribable

  has_many :posts
  has_many :subscriptions, class_name: "SourceSubscription"

  acts_as_taggable_on :tags # intended for use by curators

  def self.generate_private_handle
    100.times do
      rand_num = SecureRandom.rand(1_000_000)
      test_handle = "private#{rand_num}"
      return test_handle if where(handle: test_handle).count.zero?
    end

    raise "No handle could be generated"
  end

  def import_icon!(icon_url = nil)
    icon_url = detect_icon_url if respond_to?(:detect_icon_url) && icon_url.nil?
    return if icon_url.nil?

    "#{title.parameterize}_#{id}" => new_public_id
    Cloudinary::Uploader.upload(icon_url, public_id: new_public_id)
    update(icon_cloudinary_id: new_public_id)
  rescue StandardError => e
    Rails.logger.warn "*** ERROR: unable to import #{icon_url} for Source ##{id}: #{e.message}"
  end
end
