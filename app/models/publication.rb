# frozen_string_literal: true

# == Schema Information
#
# Table name: sources
#
#  id                 :bigint           not null, primary key
#  description        :text
#  handle             :string
#  hide_from_public   :boolean          default(FALSE)
#  latest_post_at     :datetime
#  title              :string
#  twitter_handle     :string
#  type               :string           default("Publication")
#  url                :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  icon_cloudinary_id :string
#
# Indexes
#
#  index_sources_on_type  (type)
#
class Publication < Source
  ### Defined in Source
  # has_many :posts

  has_many :feeds

  def detect_icon_url
    conn = Faraday.new do |f|
      f.use FaradayMiddleware::FollowRedirects, limit: 3
      f.adapter Faraday.default_adapter
    end
    htmldom = Nokogiri.parse(conn.get(url).body)
    SiteProcessing::Icons.new(htmldom, url).choose_best_icon
  end
end
