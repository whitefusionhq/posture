class CreateFeeds < ActiveRecord::Migration[6.1]
  def change
    create_table :feeds do |t|
      t.integer "publication_id"
      t.string "url"
      t.boolean "active"
      t.datetime "last_checked_at"
      t.boolean "no_thumbnails"
      t.boolean "bad_summary"
      t.boolean "review_requested", default: false
      t.timestamps
    end
  end
end
