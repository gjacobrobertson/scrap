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

ActiveRecord::Schema.define(:version => 20130306221026) do

  create_table "split_transactions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "splits", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.float    "amount"
    t.boolean  "confirmed"
    t.string   "note"
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "split_id"
  end

  add_index "transactions", ["from_id"], :name => "index_transactions_on_from"
  add_index "transactions", ["to_id"], :name => "index_transactions_on_to"

  create_table "users", :force => true do |t|
    t.datetime "remember_created_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
  end

end
