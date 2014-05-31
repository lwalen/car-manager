# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140531234803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "mpg"
    t.string   "slug"
  end

  create_table "records", force: true do |t|
    t.integer  "car_id",                         null: false
    t.string   "type",                           null: false
    t.date     "date"
    t.float    "mileage"
    t.float    "cost"
    t.text     "notes"
    t.float    "volume"
    t.float    "rate"
    t.boolean  "stat",            default: true, null: false
    t.integer  "service_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_types", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.integer  "number_of_gas_records",     default: 5
    t.string   "distance_unit",             default: "Miles"
    t.string   "volume_unit",               default: "Gallons"
    t.integer  "primary_car_id"
    t.integer  "number_of_service_records", default: 5
  end

end
