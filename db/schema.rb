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

ActiveRecord::Schema.define(version: 20150121053923) do

  create_table "cars", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "mpg"
    t.string   "slug"
  end

  create_table "records", force: true do |t|
    t.integer  "car_id",                    null: false
    t.string   "type",                      null: false
    t.date     "date"
    t.float    "mileage"
    t.float    "cost"
    t.text     "notes"
    t.float    "volume"
    t.float    "rate"
    t.boolean  "stat",       default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records_service_types", force: true do |t|
    t.integer  "service_record_id"
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
  end

end
