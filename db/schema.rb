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

ActiveRecord::Schema[7.0].define(version: 2022_05_27_015905) do
  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "delivery_time_lines", force: :cascade do |t|
    t.integer "init_distance"
    t.integer "final_distance"
    t.integer "delivery_time"
    t.integer "delivery_time_table_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_time_table_id"], name: "index_delivery_time_lines_on_delivery_time_table_id"
  end

  create_table "delivery_time_tables", force: :cascade do |t|
    t.integer "shipping_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_company_id"], name: "index_delivery_time_tables_on_shipping_company_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status"
    t.integer "admin_id", null: false
    t.date "date"
    t.string "code"
    t.integer "shipping_company_id", null: false
    t.integer "distance"
    t.string "pickup_adress"
    t.string "product_code"
    t.integer "width"
    t.integer "height"
    t.integer "depth"
    t.string "delivery_adress"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weight"
    t.integer "value"
    t.integer "vehicle_id"
    t.index ["admin_id"], name: "index_orders_on_admin_id"
    t.index ["shipping_company_id"], name: "index_orders_on_shipping_company_id"
    t.index ["vehicle_id"], name: "index_orders_on_vehicle_id"
  end

  create_table "price_lines", force: :cascade do |t|
    t.integer "minimum_volume"
    t.integer "maximum_volume"
    t.integer "minimum_weight"
    t.integer "maximum_weight"
    t.integer "value"
    t.integer "price_table_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_table_id"], name: "index_price_lines_on_price_table_id"
  end

  create_table "price_tables", force: :cascade do |t|
    t.integer "shipping_company_id", null: false
    t.integer "minimum_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_company_id"], name: "index_price_tables_on_shipping_company_id"
  end

  create_table "shipping_companies", force: :cascade do |t|
    t.string "name"
    t.string "corporate_name"
    t.string "email_domain"
    t.string "cnpj"
    t.string "billing_adress"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.integer "shipping_company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["shipping_company_id"], name: "index_users_on_shipping_company_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate"
    t.string "brand_model"
    t.date "year"
    t.integer "weight_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id", null: false
    t.index ["shipping_company_id"], name: "index_vehicles_on_shipping_company_id"
  end

  add_foreign_key "delivery_time_lines", "delivery_time_tables"
  add_foreign_key "delivery_time_tables", "shipping_companies"
  add_foreign_key "orders", "admins"
  add_foreign_key "orders", "shipping_companies"
  add_foreign_key "price_lines", "price_tables"
  add_foreign_key "price_tables", "shipping_companies"
  add_foreign_key "users", "shipping_companies"
  add_foreign_key "vehicles", "shipping_companies"
end
