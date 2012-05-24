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

ActiveRecord::Schema.define(:version => 20120421203448) do

  create_table "departments", :force => true do |t|
    t.string   "title"
    t.date     "ndate"
    t.time     "ntime"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "city"
    t.string   "address"
    t.integer  "group_id"
    t.string   "lon"
    t.string   "lat"
    t.time     "time_t"
    t.date     "date_t"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "city"
    t.string   "zip"
    t.string   "groupkey"
    t.text     "topics"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invindices", :force => true do |t|
    t.string   "word"
    t.text     "docid"
    t.integer  "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invindices", ["docid"], :name => "index_invindices_on_docid"
  add_index "invindices", ["word"], :name => "index_invindices_on_word"

  create_table "logins", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rsvps", :force => true do |t|
    t.integer  "student_id"
    t.integer  "group_id"
    t.integer  "event_id"
    t.date     "rsvpdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stdregisters", :force => true do |t|
    t.string   "stdid"
    t.text     "modules"
    t.string   "tutor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "stdid"
    t.string   "email"
    t.string   "password"
    t.text     "bhistory"
    t.text     "modules"
    t.text     "rsvps"
    t.string   "tutor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "queryvector"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "password_confirmation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  create_table "votes", :force => true do |t|
    t.integer  "event_id"
    t.integer  "student_id"
    t.integer  "vote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["event_id"], :name => "index_votes_on_event_id"
  add_index "votes", ["student_id", "event_id"], :name => "index_votes_on_student_id_and_event_id", :unique => true
  add_index "votes", ["student_id"], :name => "index_votes_on_student_id"

  create_table "wordsdocs", :force => true do |t|
    t.integer  "docid"
    t.integer  "words"
    t.text     "tf"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wordsdocs", ["docid"], :name => "index_wordsdocs_on_docid"
  add_index "wordsdocs", ["tf"], :name => "index_wordsdocs_on_tf"

end
