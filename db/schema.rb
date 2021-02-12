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

ActiveRecord::Schema.define(version: 2021_02_12_232446) do

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

  create_table "onlines", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "kana_name"
    t.string "parent_name"
    t.integer "gender"
    t.date "birthday"
    t.string "school"
    t.integer "grade", default: 0
    t.integer "prefecture", default: 0
    t.text "address"
    t.string "phone"
    t.string "parent_email"
    t.integer "subject", default: 0
    t.string "membership_number"
    t.boolean "status", default: true, null: false
    t.index ["email"], name: "index_onlines_on_email", unique: true
    t.index ["reset_password_token"], name: "index_onlines_on_reset_password_token", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "studies", force: :cascade do |t|
    t.integer "online_id"
    t.integer "question_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.integer "online_id"
    t.boolean "math_iaf", default: false, null: false
    t.integer "question_iaf"
    t.integer "stage_iaf"
    t.boolean "math_ias", default: false, null: false
    t.integer "question_ias"
    t.integer "stage_ias"
    t.boolean "math_iibf", default: false, null: false
    t.integer "question_iibf"
    t.integer "stage_iibf"
    t.boolean "math_iibs", default: false, null: false
    t.integer "question_iibs"
    t.integer "stage_iibs"
    t.boolean "math_iiicf", default: false, null: false
    t.integer "question_iiicf"
    t.integer "stage_iiicf"
    t.boolean "math_iiics", default: false, null: false
    t.integer "question_iiics"
    t.integer "stage_iiics"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
