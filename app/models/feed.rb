# frozen_string_literal: true

class Feed < ApplicationRecord
  belongs_to :publication, optional: true

  scope :active, -> { where active: true }

  validates :url, uniqueness: true
end
