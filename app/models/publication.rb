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
class Publication < Source
  ### Defined in Source
  # has_many :posts
  # has_many :subscriptions

  has_many :feeds
end
