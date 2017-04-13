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

ActiveRecord::Schema.define(version: 20170411162221) do

  create_table "examples", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "has_issues_comments", force: :cascade do |t|
    t.integer  "issue_id"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.integer  "editor_id"
    t.string   "editor_type"
    t.text     "body"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["creator_id", "creator_type", "issue_id"], name: "index_has_issues_comments_on_c_id_and_c_type_and_i_id"
    t.index ["issue_id"], name: "index_has_issues_comments_on_issue_id"
  end

  create_table "has_issues_issues", force: :cascade do |t|
    t.integer  "issueable_id"
    t.string   "issueable_type"
    t.integer  "issuer_id"
    t.string   "issuer_type"
    t.string   "title"
    t.integer  "closer_id"
    t.string   "closer_type"
    t.datetime "closed_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["issueable_id", "issueable_type"], name: "index_has_issues_issues_on_i_id_and_i_type"
  end

  create_table "has_issues_subscriptions", force: :cascade do |t|
    t.integer  "issue_id"
    t.integer  "subscriber_id"
    t.string   "subscriber_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["issue_id"], name: "index_has_issues_subscriptions_on_issue_id"
    t.index ["subscriber_id", "subscriber_type", "issue_id"], name: "index_has_issues_subscriptions_on_s_id_and_s_type_and_i_id", unique: true
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
