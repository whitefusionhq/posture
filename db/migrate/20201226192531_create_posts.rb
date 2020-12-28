class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string "title"
      t.string "url"
      t.text "excerpt"
      t.string "thumbnail_url"
      t.integer "source_id"
      t.datetime "published_at"
      t.integer "feed_id"
      t.index ["source_id"], name: "index_posts_on_source_id"
      t.index ["published_at"], name: "index_posts_on_published_at"

      t.timestamps
    end
  end
end
