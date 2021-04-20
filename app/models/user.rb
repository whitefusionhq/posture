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

  has_many :source_subscriptions
  has_many :sources, through: :source_subscriptions

  has_many :tags, through: :source_subscriptions

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: %r{\A(.+)@(.+)\z}, message: "is invalid" }
  validates :password, length: { minimum: 8 }, if: ->(user) { !user.password.nil? }

  def subscribed_to?(source)
    sources.where("sources.id = ?", source.id).count.positive?
  end

  def subscription_for_source(source)
    source_subscriptions.joins(:source).where("sources.id = ?", source.id).first
  end
end
