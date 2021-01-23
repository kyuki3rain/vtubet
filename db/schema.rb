# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_21_015435) do

  create_table "bets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "point", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.integer "chance_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chance_id"], name: "index_bets_on_chance_id"
    t.index ["user_id", "chance_id"], name: "index_bets_on_user_id_and_chance_id", unique: true
  end

  create_table "chances", force: :cascade do |t|
    t.integer "participation_id", null: false
    t.integer "bet_type"
    t.integer "rate"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["participation_id"], name: "index_chances_on_participation_id"
  end

  create_table "contests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "refund"
    t.integer "status"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_contests_on_user_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "participations", force: :cascade do |t|
    t.integer "contest_id", null: false
    t.integer "member_id", null: false
    t.integer "rank"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contest_id", "member_id"], name: "index_participations_on_contest_id_and_member_id", unique: true
    t.index ["member_id"], name: "index_participations_on_member_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "authority", default: 0, null: false
    t.integer "point", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "bets", "chances"
  add_foreign_key "bets", "users"
  add_foreign_key "chances", "participations"
  add_foreign_key "contests", "users"
  add_foreign_key "participations", "contests"
  add_foreign_key "participations", "members"
end
