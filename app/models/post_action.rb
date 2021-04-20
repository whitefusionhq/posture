# frozen_string_literal: true

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
class PostAction < ApplicationRecord
  belongs_to :post
  belongs_to :user

  enum action_type: [:bookmark, :flag, :favorite]
end
