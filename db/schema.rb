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

ActiveRecord::Schema.define(version: 2021_07_30_143715) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "membership_number"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "answer_images", force: :cascade do |t|
    t.integer "study_id"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendars", force: :cascade do |t|
    t.string "title"
    t.boolean "check"
    t.datetime "start_time"
  end

  create_table "correction_images", force: :cascade do |t|
    t.integer "study_id"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notification_histories", force: :cascade do |t|
    t.integer "online_id"
    t.integer "notification_id"
    t.boolean "checked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "numberings", force: :cascade do |t|
    t.integer "final_number"
  end

  create_table "onlines", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "kana_name", default: "", null: false
    t.string "parent_name", default: "", null: false
    t.integer "gender", default: 0, null: false
    t.date "birthday"
    t.string "high_school"
    t.string "junior_high_school"
    t.string "elementary_school"
    t.integer "grade", default: 0, null: false
    t.string "postal_code", default: "", null: false
    t.integer "prefecture", default: 0, null: false
    t.string "address", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "parent_email", default: "", null: false
    t.integer "course", default: 0, null: false
    t.integer "math_iaf", default: 0
    t.integer "math_ias", default: 0
    t.integer "math_iibf", default: 0
    t.integer "math_iibs", default: 0
    t.integer "math_iiicf", default: 0
    t.integer "math_iiics", default: 0
    t.integer "membership_number"
    t.boolean "status", default: true, null: false
    t.string "note"
    t.index ["email"], name: "index_onlines_on_email", unique: true
    t.index ["reset_password_token"], name: "index_onlines_on_reset_password_token", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.integer "online_id"
    t.integer "course"
    t.boolean "paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
  end

  create_table "studies", force: :cascade do |t|
    t.integer "online_id"
    t.integer "question_id"
    t.integer "answer_time"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.integer "online_id"
    t.integer "course"
    t.integer "question"
    t.integer "stage"
    t.datetime "lesson1"
    t.datetime "lesson2"
    t.datetime "lesson3"
    t.datetime "lesson4"
    t.datetime "lesson5"
    t.datetime "lesson6"
    t.datetime "lesson7"
    t.datetime "lesson8"
    t.datetime "lesson9"
    t.datetime "lesson10"
    t.datetime "lesson11"
    t.datetime "lesson12"
    t.datetime "lesson13"
    t.datetime "lesson14"
    t.datetime "lesson15"
    t.datetime "lesson16"
    t.datetime "lesson17"
    t.datetime "lesson18"
    t.datetime "lesson19"
    t.datetime "lesson20"
    t.datetime "lesson21"
    t.datetime "lesson22"
    t.integer "postphonement", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["online_id", "course"], name: "index_subjects_on_online_id_and_course", unique: true
  end

end
