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

ActiveRecord::Schema.define(:version => 20111108143611) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "total_amount",     :default => 0
    t.integer  "available_amount", :default => 0
    t.integer  "freeze_amount",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :id => false, :force => true do |t|
    t.string "id",       :limit => 50
    t.string "code",     :limit => 50
    t.string "name",     :limit => 50
    t.string "currency", :limit => 10
  end

  create_table "majors", :id => false, :force => true do |t|
    t.string "id",   :limit => 50
    t.string "code", :limit => 50
    t.string "name", :limit => 50
  end

  create_table "schools", :force => true do |t|
    t.string   "country_id",  :limit => 50
    t.string   "name",        :limit => 50
    t.string   "description", :limit => 500
    t.string   "url",         :limit => 100
    t.string   "address",     :limit => 100
    t.integer  "expense"
    t.integer  "rank"
    t.float    "gre"
    t.float    "gpa"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "toefl"
    t.float    "ielts"
    t.float    "gmat"
    t.string   "photo",       :limit => 200
  end

  create_table "students", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", :force => true do |t|
    t.string   "business"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "type"
    t.string   "address",                :limit => 50
    t.string   "im",                     :limit => 50
    t.string   "telephone",              :limit => 20
    t.string   "about",                  :limit => 500
    t.string   "business",               :limit => 20
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
