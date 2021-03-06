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

ActiveRecord::Schema.define(version: 20160529190256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

  add_index "episodes", ["show_id"], name: "index_episodes_on_show_id", using: :btree

  create_table "shows", force: :cascade do |t|
    t.string   "name"
    t.integer  "tvdbId"
    t.boolean  "canceled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "previous_episode_id"
    t.integer  "next_episode_id"
  end

  add_index "shows", ["next_episode_id"], name: "index_shows_on_next_episode_id", using: :btree
  add_index "shows", ["previous_episode_id"], name: "index_shows_on_previous_episode_id", using: :btree
  add_index "shows", ["tvdbId"], name: "index_shows_on_tvdbId", unique: true, using: :btree

end
