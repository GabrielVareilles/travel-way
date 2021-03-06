# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171012120757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "place_name"
    t.string "display_address"
    t.string "display_phone"
    t.string "image_url"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.string "yelp_id"
    t.text "reviews"
    t.index ["yelp_id"], name: "index_activities_on_yelp_id", unique: true
  end

  create_table "activities_trips", id: false, force: :cascade do |t|
    t.bigint "activity_id"
    t.bigint "trip_id"
    t.index ["activity_id"], name: "index_activities_trips_on_activity_id"
    t.index ["trip_id"], name: "index_activities_trips_on_trip_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_places_on_activity_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.date "start_date"
    t.date "end_date"
    t.string "places", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "activity_ids", default: [], array: true
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "first_name"
    t.string "last_name"
    t.string "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "places", "activities"
  add_foreign_key "trips", "users"
end
