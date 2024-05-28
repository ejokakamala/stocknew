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

ActiveRecord::Schema[7.1].define(version: 2024_05_25_102015) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", force: :cascade do |t|
    t.integer "batch_no"
    t.string "flock_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", default: 2, null: false
    t.index ["user_id"], name: "index_batches_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.date "date"
    t.string "category"
    t.integer "quantity"
    t.integer "unit_price"
    t.integer "total_amount"
    t.text "description"
    t.bigint "batch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", default: 2, null: false
    t.index ["batch_id"], name: "index_expenses_on_batch_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "fixed_expenses", force: :cascade do |t|
    t.date "date_in"
    t.string "type_of_expense"
    t.integer "cost"
    t.integer "quantity"
    t.integer "total_cost"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", default: 2, null: false
    t.index ["user_id"], name: "index_fixed_expenses_on_user_id"
  end

  create_table "flocks", force: :cascade do |t|
    t.integer "batch_no"
    t.datetime "date_in"
    t.date "retirement_date"
    t.string "source"
    t.integer "initial_stock", default: 0
    t.integer "died_stock", default: 0
    t.integer "age"
    t.text "notes"
    t.string "status"
    t.integer "sold_stock", default: 0
    t.bigint "batch_id", null: false
    t.bigint "user_id", default: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_flocks_on_batch_id"
    t.index ["user_id"], name: "index_flocks_on_user_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.date "date"
    t.string "category"
    t.integer "quantity"
    t.integer "unit_price"
    t.integer "total_amount"
    t.text "description"
    t.bigint "batch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", default: 2, null: false
    t.index ["batch_id"], name: "index_incomes_on_batch_id"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "batches", "users"
  add_foreign_key "expenses", "batches"
  add_foreign_key "expenses", "users"
  add_foreign_key "fixed_expenses", "users"
  add_foreign_key "flocks", "batches"
  add_foreign_key "flocks", "users"
  add_foreign_key "incomes", "batches"
  add_foreign_key "incomes", "users"
end
