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

ActiveRecord::Schema.define(version: 20170921012048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessibilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "external_id"
  end

  create_table "apps", force: :cascade do |t|
    t.string "channel"
    t.string "os"
    t.string "device"
    t.string "name"
    t.string "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_records", force: :cascade do |t|
    t.integer "member_id"
    t.integer "movement"
    t.integer "amount"
    t.datetime "occurred_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credits", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "amount"
  end

  create_table "materials", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pack_items", force: :cascade do |t|
    t.integer "pack_id"
    t.string "unit_type"
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_type", "unit_id"], name: "index_pack_items_on_unit_type_and_unit_id"
  end

  create_table "packs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "app_id"
    t.string "external_id"
    t.string "name"
    t.boolean "subscribable"
    t.boolean "extendable"
    t.integer "period_num"
    t.string "period_unit"
  end

  create_table "receipts", force: :cascade do |t|
    t.integer "member_id"
    t.integer "pack_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "channel"
    t.boolean "sandbox"
    t.datetime "deleted_at"
    t.datetime "purchased_at"
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.text "raw_data"
  end

  create_table "storages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "capacity"
  end

end
