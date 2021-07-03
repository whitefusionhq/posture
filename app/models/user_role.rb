# frozen_string_literal: true

class UserRole < ApplicationRecord
  belongs_to :user

  def self.admin_only
    where(role: "admin")
  end

  def admin?
    role == "admin"
  end
end
