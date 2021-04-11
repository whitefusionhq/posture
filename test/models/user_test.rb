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
require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "validations" do
    should "require email uniqueness" do
      u = User.create(email: "sayid@lost.com", password: "abc123456")
      refute u.valid?
      assert_equal 1, u.errors.count
    end

    should "ensure proper email format" do
      u = User.create(email: "blah", password: "abc123456")
      assert_contains u.errors.full_messages, "Email is invalid"
    end

    should "verify password length" do
      u = User.create(email: "desmond@constant.com", password: "4815")
      assert_equal :too_short, u.errors.first.type

      u = User.create(email: "desmond@constant.com", password: 50.times.to_a.join)
      assert_equal :too_long, u.errors.first.type
    end
  end
end
