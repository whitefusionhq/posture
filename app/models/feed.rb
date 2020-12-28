# frozen_string_literal: true

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

  def importer
    @importer ||= Importers::FeedImporter.new(self)
  end
end
