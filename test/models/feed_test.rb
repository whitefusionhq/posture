# == Schema Information
#
# Table name: feeds
#
#  id               :bigint           not null, primary key
#  active           :boolean
#  bad_summary      :boolean
#  last_checked_at  :datetime
#  no_thumbnails    :boolean
#  review_requested :boolean          default(FALSE)
#  url              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  publication_id   :integer
#
require "test_helper"

class FeedTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
