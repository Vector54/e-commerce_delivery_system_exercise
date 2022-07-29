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

ActiveRecord::Schema[7.0].define(version: 2022_07_11_232132) do
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id", null: false
    t.index ["shipping_company_id"], name: "index_delivery_time_lines_on_shipping_company_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id", null: false
    t.index ["shipping_company_id"], name: "index_price_lines_on_shipping_company_id"
  end

  create_table "shipping_companies", force: :cascade do |t|
    t.string "name"
    t.string "corporate_name"
    t.string "email_domain"
    t.string "cnpj"
    t.string "billing_adress"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "minimum_value", default: 0
    t.index ["cnpj"], name: "index_shipping_companies_on_cnpj", unique: true
  end

  create_table "update_lines", force: :cascade do |t|
    t.string "coordinates"
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_update_lines_on_order_id"
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
    t.string "year"
    t.integer "weight_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_company_id", null: false
    t.index ["shipping_company_id"], name: "index_vehicles_on_shipping_company_id"
  end

  add_foreign_key "delivery_time_lines", "shipping_companies"
  add_foreign_key "orders", "admins"
  add_foreign_key "orders", "shipping_companies"
  add_foreign_key "price_lines", "shipping_companies"
  add_foreign_key "update_lines", "orders"
  add_foreign_key "users", "shipping_companies"
  add_foreign_key "vehicles", "shipping_companies"
end
