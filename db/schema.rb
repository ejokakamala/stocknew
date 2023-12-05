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

ActiveRecord::Schema[7.1].define(version: 2023_12_05_195811) do
  create_table "batches", force: :cascade do |t|
    t.integer "batch_no"
    t.string "flock_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.date "date"
    t.string "category"
    t.integer "quantity"
    t.integer "unit_price"
    t.integer "total_amount"
    t.text "description"
    t.integer "batch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_expenses_on_batch_id"
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
  end

  create_table "flocks", force: :cascade do |t|
    t.integer "batch_no"
    t.date "date_in"
    t.date "retirement_date"
    t.string "source"
    t.integer "initial_stock"
    t.integer "died_stock", default: 0
    t.integer "age"
    t.text "notes"
    t.string "status"
    t.integer "sold_stock", default: 0
    t.integer "batch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_flocks_on_batch_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.date "date"
    t.string "category"
    t.integer "quantity"
    t.integer "unit_price"
    t.integer "total_amount"
    t.text "description"
    t.integer "batch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_incomes_on_batch_id"
  end

  add_foreign_key "expenses", "batches"
  add_foreign_key "flocks", "batches"
  add_foreign_key "incomes", "batches"
end
