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

ActiveRecord::Schema.define(version: 2021_06_05_193338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "pgjwt"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "birthday"
    t.string "telephone"
    t.string "address"
    t.string "credit_card"
    t.string "franchise"
    t.string "email"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "failed_contacts", force: :cascade do |t|
    t.integer "row_number"
    t.bigint "uploaded_contacts_file_id", null: false
    t.string "reason"
    t.string "json_data"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uploaded_contacts_file_id"], name: "index_failed_contacts_on_uploaded_contacts_file_id"
    t.index ["user_id"], name: "index_failed_contacts_on_user_id"
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.string "token"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_refresh_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "uploaded_contacts_files", force: :cascade do |t|
    t.string "name"
    t.string "document"
    t.string "document_processing"
    t.string "status"
    t.string "fields_order"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_uploaded_contacts_files_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "failed_contacts", "uploaded_contacts_files"
  add_foreign_key "failed_contacts", "users"
  add_foreign_key "refresh_tokens", "users"
  add_foreign_key "uploaded_contacts_files", "users"
end
