# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_02_041815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feeds", force: :cascade do |t|
    t.integer "publication_id"
    t.string "url"
    t.boolean "active"
    t.datetime "last_checked_at"
    t.boolean "no_thumbnails"
    t.boolean "bad_summary"
    t.boolean "review_requested", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "post_actions", force: :cascade do |t|
    t.integer "action_type"
    t.integer "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "excerpt"
    t.string "thumbnail_url"
    t.integer "source_id"
    t.datetime "published_at"
    t.integer "feed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["published_at"], name: "index_posts_on_published_at"
    t.index ["source_id"], name: "index_posts_on_source_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "description"
    t.string "icon_cloudinary_id"
    t.string "handle"
    t.string "twitter_handle"
    t.boolean "hide_from_public", default: false
    t.boolean "featured_in_discover", default: false
    t.string "type", default: "Publication"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "latest_post_at"
    t.index ["type"], name: "index_sources_on_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
