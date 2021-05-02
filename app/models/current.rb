# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  # @!parse def self.user = User.new
  attribute :user

  #  resets { Time.zone = nil }

  # def user=(user)
  #   super
  #   Time.zone    = user.time_zone
  # end
end
