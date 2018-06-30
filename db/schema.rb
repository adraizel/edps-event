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

ActiveRecord::Schema.define(version: 20180000000003) do

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "markdown", default: false
    t.integer "charge"
    t.string "location"
    t.datetime "start_time"
    t.date "join_limit"
    t.integer "owner_id"
    t.boolean "official", default: false
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_events", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.text "remark", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "event_id"], name: "index_user_events_on_user_id_and_event_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.integer "entrance_year", null: false
    t.string "student_number", null: false
    t.date "birthday", null: false
    t.string "allergy_data", default: ""
    t.string "remark", default: ""
    t.boolean "executive", default: false
    t.boolean "mailer", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["student_number"], name: "index_users_on_student_number", unique: true
  end

end
