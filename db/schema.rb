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

ActiveRecord::Schema.define(version: 20171201092547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "plaid_institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "name"
    t.string "plaid_id"
    t.string "plaid_name"
    t.string "plaid_type"
    t.string "plaid_sub_type"
    t.bigint "authorization_id"
    t.string "plaid_official_name"
    t.datetime "last_synced_at"
    t.index ["authorization_id"], name: "index_accounts_on_authorization_id"
    t.index ["plaid_institution_id"], name: "index_accounts_on_plaid_institution_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "authorizations", force: :cascade do |t|
    t.bigint "plaid_institution_id"
    t.bigint "user_id"
    t.string "public_token"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.index ["plaid_institution_id"], name: "index_authorizations_on_plaid_institution_id"
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "classifications", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group"
  end

  create_table "plaid_institutions", force: :cascade do |t|
    t.string "name"
    t.string "plaid_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "json"
  end

  create_table "rules", force: :cascade do |t|
    t.string "regex"
    t.bigint "classification_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classification_id"], name: "index_rules_on_classification_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.date "date"
    t.string "description"
    t.bigint "classification_id"
    t.bigint "rule_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.string "plaid_account_owner"
    t.boolean "plaid_pending"
    t.string "plaid_id"
    t.string "plaid_transaction_type"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["classification_id"], name: "index_transactions_on_classification_id"
    t.index ["rule_id"], name: "index_transactions_on_rule_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "authorizations"
  add_foreign_key "accounts", "plaid_institutions"
  add_foreign_key "accounts", "users"
  add_foreign_key "authorizations", "plaid_institutions"
  add_foreign_key "authorizations", "users"
  add_foreign_key "rules", "classifications"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "classifications"
  add_foreign_key "transactions", "rules"
end
