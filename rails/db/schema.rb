# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090406095717) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.string   "question_type"
    t.text     "answer_string"
    t.string   "answer_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "completions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.date     "paid_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country",       :default => "AMERRRRICA! FUCK YYEEAAH!"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_id"
    t.string   "question_type"
  end

  create_table "surveys", :force => true do |t|
    t.string   "name"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete",   :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.boolean  "admin",                                    :default => false, :null => false
    t.date     "birthdate"
    t.integer  "income"
    t.string   "gender"
  end

  add_index "users", ["login"], :name => "index_sams_on_login", :unique => true

  create_table "wallet_transactions", :force => true do |t|
    t.integer  "wallet_id"
    t.float    "amount"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wallets", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
