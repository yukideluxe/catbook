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

ActiveRecord::Schema.define(version: 20141021180707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cats", force: true do |t|
    t.string   "name"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",         default: true
    t.string   "email"
    t.text     "password_digest"
  end

  add_index "cats", ["email"], name: "index_cats_on_email", unique: true, using: :btree

  create_table "cron_example_tables", force: true do |t|
    t.datetime "current_time"
  end

  create_table "cron_examples", force: true do |t|
    t.datetime "current_time"
  end

  create_table "follower_relations", force: true do |t|
    t.integer  "cat_id"
    t.integer  "followed_cat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follower_relations", ["cat_id"], name: "index_follower_relations_on_cat_id", using: :btree
  add_index "follower_relations", ["followed_cat_id"], name: "index_follower_relations_on_followed_cat_id", using: :btree

end
