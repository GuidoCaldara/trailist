# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_04_092033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "logo"
    t.text "description"
    t.bigint "user_id"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "website"
    t.string "facebook"
    t.string "slug"
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "organizers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_organizers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_organizers_on_reset_password_token", unique: true
  end

  create_table "race_photos", force: :cascade do |t|
    t.bigint "race_id"
    t.string "picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["race_id"], name: "index_race_photos_on_race_id"
  end

  create_table "race_prices", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "price"
    t.bigint "race_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["race_id"], name: "index_race_prices_on_race_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.integer "length"
    t.integer "elevation"
    t.date "date"
    t.time "departure_time"
    t.text "description"
    t.text "goodies"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.bigint "organization_id"
    t.string "race_type"
    t.boolean "single_price"
    t.string "cover_picture"
    t.text "rules"
    t.text "website"
    t.string "video"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "distance_type"
    t.string "slug"
    t.index ["organization_id"], name: "index_races_on_organization_id"
    t.index ["slug"], name: "index_races_on_slug", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "race_id", null: false
    t.bigint "user_id", null: false
    t.integer "partecipation_year"
    t.integer "track"
    t.integer "organization"
    t.integer "recomandation"
    t.integer "difficulty"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["race_id"], name: "index_reviews_on_race_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "avatar"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.text "description"
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

  add_foreign_key "organizations", "users"
  add_foreign_key "race_photos", "races"
  add_foreign_key "race_prices", "races"
  add_foreign_key "races", "organizations"
  add_foreign_key "reviews", "races"
  add_foreign_key "reviews", "users"
end
