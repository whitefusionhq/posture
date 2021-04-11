# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: %r{\A(.+)@(.+)\z}, message: "is invalid" }
  validates :password, length: { minimum: 8 }, if: ->(user) { !user.password.nil? }
end
