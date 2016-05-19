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

ActiveRecord::Schema.define(version: 20160519102237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.integer  "category"
    t.datetime "date"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "entity_id"
  end

  add_index "events", ["entity_id"], name: "index_events_on_entity_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "gender"
    t.string   "tel"
    t.string   "mob"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "entity_id"
  end

  add_index "members", ["entity_id"], name: "index_members_on_entity_id", using: :btree

  create_table "question_responses", force: :cascade do |t|
    t.string   "response"
    t.integer  "entity_id"
    t.integer  "member_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
  end

  add_index "question_responses", ["entity_id"], name: "index_question_responses_on_entity_id", using: :btree
  add_index "question_responses", ["member_id"], name: "index_question_responses_on_member_id", using: :btree
  add_index "question_responses", ["question_id"], name: "index_question_responses_on_question_id", using: :btree

  create_table "question_sets", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_sets_questions", id: false, force: :cascade do |t|
    t.integer "question_id",     null: false
    t.integer "question_set_id", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "question",   null: false
    t.string   "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "category"
  end

  add_foreign_key "events", "entities"
  add_foreign_key "members", "entities"
  add_foreign_key "question_responses", "entities"
  add_foreign_key "question_responses", "members"
  add_foreign_key "question_responses", "questions"
end
