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

ActiveRecord::Schema.define(version: 20161005122327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arrangers", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "arrangers", ["event_id"], name: "index_arrangers_on_event_id", using: :btree
  add_index "arrangers", ["project_id"], name: "index_arrangers_on_project_id", using: :btree

  create_table "attendances", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attendances", ["event_id"], name: "index_attendances_on_event_id", using: :btree
  add_index "attendances", ["member_id"], name: "index_attendances_on_member_id", using: :btree

  create_table "calendars", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "is_funded_default"
    t.string   "url"
    t.integer  "region_default"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "calendars", ["project_id"], name: "index_calendars_on_project_id", using: :btree

  create_table "entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.integer  "category"
    t.datetime "start"
    t.string   "description"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "entity_id"
    t.datetime "finish"
    t.string   "google_id"
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "event_type"
    t.string   "event_type_other"
    t.boolean  "is_funded",        default: false
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
    t.integer  "entity_id"
  end

  add_index "locations", ["entity_id"], name: "index_locations_on_entity_id", using: :btree

  create_table "member_locations", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "location_id"
    t.date     "from"
    t.date     "to"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "member_locations", ["location_id"], name: "index_member_locations_on_location_id", using: :btree
  add_index "member_locations", ["member_id"], name: "index_member_locations_on_member_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "tel"
    t.string   "mob"
    t.string   "email"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "entity_id"
    t.integer  "region"
    t.string   "notes"
    t.boolean  "is_resident"
    t.integer  "ethnic_background"
    t.string   "ethnic_background_other"
  end

  add_index "members", ["entity_id"], name: "index_members_on_entity_id", using: :btree

  create_table "organisations", force: :cascade do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "organisations", ["location_id"], name: "index_organisations_on_location_id", using: :btree

  create_table "partners", force: :cascade do |t|
    t.date     "start"
    t.date     "finish"
    t.integer  "partner_type"
    t.integer  "organisation_id"
    t.integer  "project_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "partners", ["organisation_id"], name: "index_partners_on_organisation_id", using: :btree
  add_index "partners", ["project_id"], name: "index_partners_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.date     "start"
    t.date     "finish"
    t.integer  "primary_partner_organisation_id"
    t.integer  "resident_champion_id"
    t.integer  "resident_seconder_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "entity_id"
    t.integer  "region"
  end

  add_index "projects", ["entity_id"], name: "index_projects_on_entity_id", using: :btree
  add_index "projects", ["primary_partner_organisation_id"], name: "index_projects_on_primary_partner_organisation_id", using: :btree
  add_index "projects", ["resident_champion_id"], name: "index_projects_on_resident_champion_id", using: :btree
  add_index "projects", ["resident_seconder_id"], name: "index_projects_on_resident_seconder_id", using: :btree

  create_table "question_lists", force: :cascade do |t|
    t.integer "question_id"
    t.integer "question_set_id"
    t.integer "weight"
  end

  add_index "question_lists", ["question_id"], name: "index_question_lists_on_question_id", using: :btree
  add_index "question_lists", ["question_set_id"], name: "index_question_lists_on_question_set_id", using: :btree

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

  create_table "questions", force: :cascade do |t|
    t.string   "question",   null: false
    t.string   "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "category"
  end

  create_table "representatives", force: :cascade do |t|
    t.string   "job_title"
    t.date     "start"
    t.date     "finish"
    t.integer  "member_id"
    t.integer  "organisation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "representatives", ["member_id"], name: "index_representatives_on_member_id", using: :btree
  add_index "representatives", ["organisation_id"], name: "index_representatives_on_organisation_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "default_ward"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "volunteers", force: :cascade do |t|
    t.string   "role"
    t.boolean  "is_leader"
    t.date     "start"
    t.date     "finish"
    t.integer  "member_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "volunteers", ["member_id"], name: "index_volunteers_on_member_id", using: :btree
  add_index "volunteers", ["project_id"], name: "index_volunteers_on_project_id", using: :btree

  add_foreign_key "arrangers", "events"
  add_foreign_key "arrangers", "projects"
  add_foreign_key "attendances", "events"
  add_foreign_key "attendances", "members"
  add_foreign_key "calendars", "projects"
  add_foreign_key "events", "entities"
  add_foreign_key "locations", "entities"
  add_foreign_key "member_locations", "locations"
  add_foreign_key "member_locations", "members"
  add_foreign_key "members", "entities"
  add_foreign_key "organisations", "locations"
  add_foreign_key "partners", "organisations"
  add_foreign_key "partners", "projects"
  add_foreign_key "projects", "entities"
  add_foreign_key "projects", "members", column: "resident_champion_id"
  add_foreign_key "projects", "members", column: "resident_seconder_id"
  add_foreign_key "projects", "organisations", column: "primary_partner_organisation_id"
  add_foreign_key "question_lists", "question_sets"
  add_foreign_key "question_lists", "questions"
  add_foreign_key "question_responses", "entities"
  add_foreign_key "question_responses", "members"
  add_foreign_key "question_responses", "questions"
  add_foreign_key "representatives", "members"
  add_foreign_key "representatives", "organisations"
  add_foreign_key "volunteers", "members"
  add_foreign_key "volunteers", "projects"
end
