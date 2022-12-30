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

ActiveRecord::Schema[7.0].define(version: 2022_12_23_225040) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "streams", force: :cascade do |t|
    t.bigint "twitch_channel_id", null: false
    t.datetime "starts_at"
    t.integer "initial_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twitch_channel_id"], name: "index_streams_on_twitch_channel_id"
  end

  create_table "twitch_channels", force: :cascade do |t|
    t.string "twitch_id"
    t.string "username"
    t.string "display_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twitch_id"], name: "index_twitch_channels_on_twitch_id", unique: true
    t.index ["username"], name: "index_twitch_channels_on_username", unique: true
  end

  add_foreign_key "streams", "twitch_channels"
end
