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

  acts_as_taggable_on :tags

  before_create :copy_tags_from_source

  private

  # populate the user's tags with the initial curator's tags
  def copy_tags_from_source
    self.tag_list = source.tag_list
  end
end
