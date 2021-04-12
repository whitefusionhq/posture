# == Schema Information
#
# Table name: post_actions
#
#  id          :bigint           not null, primary key
#  action_type :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  post_id     :integer
#  user_id     :integer
#
require "test_helper"

class PostActionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
