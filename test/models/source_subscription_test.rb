# == Schema Information
#
# Table name: source_subscriptions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  source_id  :integer
#  user_id    :integer
#
require "test_helper"

class SourceSubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
