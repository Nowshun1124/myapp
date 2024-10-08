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

ActiveRecord::Schema[7.1].define(version: 2024_08_30_115902) do
  create_table "artists", charset: "utf8mb3", force: :cascade do |t|
    t.text "bio"
    t.json "social_links"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_artists_on_user_id"
  end

  create_table "listeners", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_listeners_on_user_id"
  end

  create_table "lives", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.datetime "scheduled_at", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["artist_id"], name: "index_lives_on_artist_id"
  end

  create_table "notifications", charset: "utf8mb3", force: :cascade do |t|
    t.text "message"
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id", "created_at"], name: "index_notifications_on_artist_id_and_created_at"
    t.index ["artist_id"], name: "index_notifications_on_artist_id"
  end

  create_table "relationships", charset: "utf8mb3", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.boolean "is_artist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "profile_text"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "artists", "users"
  add_foreign_key "listeners", "users"
  add_foreign_key "lives", "artists"
  add_foreign_key "notifications", "artists"
end
