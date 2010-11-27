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

ActiveRecord::Schema.define(:version => 20101127163439) do

  create_table "cards", :force => true do |t|
    t.text     "front"
    t.text     "back"
    t.integer  "deck_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "decks", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "front_description", :limit => 128
    t.string   "back_description",  :limit => 128
  end

  create_table "quiz_cards", :force => true do |t|
    t.integer "quiz_id"
    t.integer "card_id"
    t.boolean "visited", :default => false
    t.boolean "correct"
    t.boolean "active",  :default => false
  end

  add_index "quiz_cards", ["quiz_id"], :name => "index_quiz_cards_on_quiz_id"

  create_table "quizzes", :force => true do |t|
    t.integer  "deck_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
