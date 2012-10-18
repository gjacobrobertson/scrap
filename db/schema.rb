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

ActiveRecord::Schema.define(:version => 20120123223930) do

  create_table "costs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "description"
    t.decimal  "amount"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "costs_users", :id => false, :force => true do |t|
    t.integer "cost_id"
    t.integer "user_id"
  end

  add_index "costs_users", ["cost_id", "user_id"], :name => "index_costs_users_on_cost_id_and_user_id", :unique => true
  add_index "costs_users", ["cost_id"], :name => "index_costs_users_on_cost_id"
  add_index "costs_users", ["user_id"], :name => "index_costs_users_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  add_index "groups_users", ["group_id"], :name => "index_groups_users_on_group_id"
  add_index "groups_users", ["user_id", "group_id"], :name => "index_groups_users_on_user_id_and_group_id", :unique => true
  add_index "groups_users", ["user_id"], :name => "index_groups_users_on_user_id"

  create_table "payments", :force => true do |t|
    t.string   "description"
    t.decimal  "amount"
    t.integer  "from_id"
    t.integer  "to_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
  end

end
