# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  excerpt       :text
#  published_at  :datetime
#  thumbnail_url :string
#  title         :string
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  feed_id       :integer
#  source_id     :integer
#
# Indexes
#
#  index_posts_on_published_at  (published_at)
#  index_posts_on_source_id     (source_id)
#
require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
