class CreateSources < ActiveRecord::Migration[6.1]
  def change
    create_table :sources do |t|
      t.string "title"
      t.string "url"
      t.text "description"
      t.string "icon_cloudinary_id"
      t.string "handle"
      t.string "twitter_handle"
      t.boolean "hide_from_public", default: false
      t.boolean "featured_in_discover", default: false
      t.string "type", default: "Publication"
      t.index ["type"], name: "index_sources_on_type"

      t.timestamps
    end
  end
end
