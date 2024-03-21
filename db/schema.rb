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

ActiveRecord::Schema[7.0].define(version: 2024_03_19_165758) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budget_expenses", force: :cascade do |t|
    t.decimal "amount"
    t.string "name"
    t.text "purpose"
    t.bigint "budget_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_budget_expenses_on_budget_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string "name"
    t.string "purpose"
    t.decimal "target_amount", precision: 10, scale: 2
    t.string "category"
    t.date "target_date"
    t.string "contribution_type"
    t.decimal "contribution_amount", precision: 10, scale: 2
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "completed", default: false, null: false
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "debt_mgts", force: :cascade do |t|
    t.string "name"
    t.text "purpose"
    t.decimal "target_amount", precision: 10, scale: 2
    t.string "contribution_type"
    t.decimal "contribution_amount", precision: 10, scale: 2
    t.date "target_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "completed", default: false, null: false
    t.decimal "interest_rate", precision: 10, scale: 2
    t.index ["user_id"], name: "index_debt_mgts_on_user_id"
  end

  create_table "debt_payments", force: :cascade do |t|
    t.string "name"
    t.decimal "amount"
    t.bigint "debt_mgt_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["debt_mgt_id"], name: "index_debt_payments_on_debt_mgt_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "name"
    t.text "purpose"
    t.decimal "cost", precision: 10, scale: 2
    t.string "decimal"
    t.string "category"
    t.string "payment_method"
    t.string "frequency"
    t.string "recipient"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "completed", default: false, null: false
    t.index ["name"], name: "index_expenses_on_name", unique: true
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "financial_plans", force: :cascade do |t|
    t.string "name"
    t.string "purpose"
    t.decimal "target_amount", precision: 10, scale: 2
    t.date "target_date"
    t.string "category"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "completed", default: false, null: false
    t.index ["user_id"], name: "index_financial_plans_on_user_id"
  end

  create_table "income_data", force: :cascade do |t|
    t.string "name"
    t.decimal "amount"
    t.bigint "income_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["income_id"], name: "index_income_data_on_income_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "income_frequency"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "item_type"
    t.boolean "read", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "saving_budgets", force: :cascade do |t|
    t.string "name"
    t.decimal "amount"
    t.bigint "saving_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["saving_id"], name: "index_saving_budgets_on_saving_id"
  end

  create_table "savings", force: :cascade do |t|
    t.string "name"
    t.string "purpose"
    t.decimal "target_amount", precision: 10, scale: 2
    t.string "category"
    t.date "target_date"
    t.string "contribution_type"
    t.decimal "contribution_amount", precision: 10, scale: 2
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "completed", default: false, null: false
    t.index ["user_id"], name: "index_savings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "activation_token"
    t.boolean "activated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "reset_token_expires_at"
    t.datetime "activation_token_expires_at"
    t.string "reset_token"
    t.string "avatar"
  end

  add_foreign_key "budget_expenses", "budgets"
  add_foreign_key "budgets", "users"
  add_foreign_key "debt_mgts", "users"
  add_foreign_key "debt_payments", "debt_mgts"
  add_foreign_key "expenses", "users"
  add_foreign_key "financial_plans", "users"
  add_foreign_key "income_data", "incomes"
  add_foreign_key "incomes", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "saving_budgets", "savings"
  add_foreign_key "savings", "users"
end
