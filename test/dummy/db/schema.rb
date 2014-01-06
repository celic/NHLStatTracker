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

ActiveRecord::Schema.define(version: 20140106022708) do

  create_table "deep_whale_games", force: true do |t|
    t.integer  "home_id"
    t.integer  "away_id"
    t.datetime "game_time"
    t.integer  "json_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deep_whale_players", force: true do |t|
    t.string   "name"
    t.integer  "jersey"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deep_whale_stats", force: true do |t|
    t.integer  "goals"
    t.integer  "assists"
    t.integer  "pims"
    t.integer  "toi"
    t.integer  "pm"
    t.integer  "sog"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deep_whale_teams", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
