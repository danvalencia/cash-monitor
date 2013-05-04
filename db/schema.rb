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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130504201631) do

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "maquinets", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "coin_value"
    t.integer  "coin_time"
    t.string   "location"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "contact_id"
    t.string   "machine_uuid"
  end

  create_table "sessions", :force => true do |t|
    t.integer  "maquinet_id"
    t.integer  "coin_count"
    t.integer  "coin_value"
    t.integer  "coin_time"
    t.integer  "print_count"
    t.integer  "print_time"
    t.integer  "call_count"
    t.integer  "call_value"
    t.integer  "call_time"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "session_uuid"
  end

  create_table "statuses", :force => true do |t|
    t.integer  "maquinet_id"
    t.datetime "start_ping"
    t.datetime "last_ping"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
