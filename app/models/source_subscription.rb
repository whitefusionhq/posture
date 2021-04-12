# frozen_string_literal: true

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
class SourceSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :source
end
