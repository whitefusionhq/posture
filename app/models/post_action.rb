# frozen_string_literal: true

class PostAction < ApplicationRecord
  belongs_to :post

  enum action_type: [:bookmark, :flag, :favorite]
end
