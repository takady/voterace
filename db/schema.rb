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

ActiveRecord::Schema.define(version: 20150726082200) do

  create_table "races", force: :cascade do |t|
    t.integer  "user_id",     limit: 4,   null: false
    t.string   "title",       limit: 255
    t.string   "candidate_1", limit: 255
    t.string   "candidate_2", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "email",       limit: 255
    t.string   "provider",    limit: 255, null: false
    t.string   "uid",         limit: 255, null: false
    t.string   "nickname",    limit: 255
    t.string   "image_url",   limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "race_id",    limit: 4
    t.integer  "candidate",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
