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

ActiveRecord::Schema.define(version: 20141213045829) do

  create_table "users", force: true do |t|
    t.string   "username",                       null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password",             null: false
    t.string   "password_salt",                  null: false
    t.string   "persistence_token",              null: false
    t.integer  "login_count",        default: 0, null: false
    t.integer  "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.integer  "current_login_ip"
    t.integer  "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["last_request_at"], :name => "index_users_on_last_request_at"
    t.index ["persistence_token"], :name => "index_users_on_persistence_token"
    t.index ["username"], :name => "index_users_on_username", :unique => true
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], :name => "index_posts_on_created_at"
    t.index ["user_id"], :name => "index_posts_on_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_posts_user_id"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], :name => "index_sessions_on_session_id", :unique => true
    t.index ["updated_at"], :name => "index_sessions_on_updated_at"
  end

end
