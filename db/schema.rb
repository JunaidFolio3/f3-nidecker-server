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

ActiveRecord::Schema.define(version: 2018_07_30_134135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shipping_items", force: :cascade do |t|
    t.string "name"
    t.string "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_on"
    t.datetime "delete_at"
    t.string "tracking_url"
    t.string "admin_name"
    t.integer "tax_category_id"
    t.string "code"
    t.integer "store_id"
  end

  create_table "spree_shipping_method_zones", force: :cascade do |t|
    t.integer "shipping_method_id"
    t.integer "zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tax_codes", force: :cascade do |t|
    t.string "name"
    t.string "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "amount", precision: 8, scale: 5
    t.datetime "delete_at"
    t.integer "tax_category_id"
    t.boolean "included_in_price"
    t.integer "zone_id"
    t.integer "store_id"
    t.boolean "show_rate_in_label"
  end

end
