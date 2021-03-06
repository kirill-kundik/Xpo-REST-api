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

ActiveRecord::Schema.define(version: 2020_04_10_145646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "expo_id", null: false
    t.text "text", null: false
    t.integer "likes_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expo_id"], name: "index_comments_on_expo_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "expo_models", force: :cascade do |t|
    t.string "ar_model_url", null: false
    t.string "marker_url", null: false
    t.bigint "expo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expo_id"], name: "index_expo_models_on_expo_id"
  end

  create_table "expos", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "image_url", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "location_name", null: false
    t.integer "views_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_expos_on_user_id"
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "user_expos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "expo_id", null: false
    t.boolean "liked", default: false, null: false
    t.boolean "was_liked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expo_id"], name: "index_user_expos_on_expo_id"
    t.index ["user_id"], name: "index_user_expos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "superadmin_role", default: false, null: false
    t.boolean "organizer_role", default: false, null: false
    t.boolean "user_role", default: true, null: false
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "expos"
  add_foreign_key "comments", "users"
  add_foreign_key "expo_models", "expos"
  add_foreign_key "expos", "users"
  add_foreign_key "user_expos", "expos"
  add_foreign_key "user_expos", "users"
end
