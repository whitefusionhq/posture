# frozen_string_literal: true

# == Schema Information
#
# Table name: sources
#
#  id                   :bigint           not null, primary key
#  description          :text
#  featured_in_discover :boolean          default(FALSE)
#  handle               :string
#  hide_from_public     :boolean          default(FALSE)
#  title                :string
#  twitter_handle       :string
#  type                 :string           default("Publication")
#  url                  :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  icon_cloudinary_id   :string
#
# Indexes
#
#  index_sources_on_type  (type)
#
class Source < ApplicationRecord
  def self.generate_private_handle
    100.times do
      rand_num = SecureRandom.rand(1_000_000)
      test_handle = "private#{rand_num}"
      return test_handle if where(handle: test_handle).count.zero?
    end

    raise "No handle could be generated"
  end
end
