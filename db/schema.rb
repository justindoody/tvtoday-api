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

ActiveRecord::Schema.define(version: 20160104015016) do

  create_table "episodes", force: :cascade do |t|
    t.string   "name"
    t.date     "air_date"
    t.time     "air_time"
    t.integer  "season"
    t.integer  "number"
    t.text     "description", default: ""
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "show_id"
    t.string   "kind"
  end

  add_index "episodes", ["kind"], name: "index_episodes_on_kind"
  add_index "episodes", ["show_id"], name: "index_episodes_on_show_id"

  create_table "show_logs", force: :cascade do |t|
    t.string   "log",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "tvdbId"
    t.boolean  "canceled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shows", ["tvdbId"], name: "index_shows_on_tvdbId", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
