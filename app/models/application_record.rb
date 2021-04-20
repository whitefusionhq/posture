# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :by_user, ->(user) { where(user: user) }
end
