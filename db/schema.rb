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

ActiveRecord::Schema.define(version: 20150430212014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.string   "name",                 null: false
    t.string   "email",                null: false
    t.string   "identity_type",        null: false
    t.string   "identity_id",          null: false
    t.datetime "added_to_workable_at"
    t.datetime "last_error_at"
    t.string   "last_error_code"
    t.text     "last_error_message"
    t.integer  "job_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidates", ["job_id"], name: "index_candidates_on_job_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "shortcode",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["shortcode"], name: "index_jobs_on_shortcode", unique: true, using: :btree

end
