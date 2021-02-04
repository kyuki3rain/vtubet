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

ActiveRecord::Schema.define(version: 2021_02_04_093929) do

  create_table "bets", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "point", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.bigint "chance_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chance_id"], name: "index_bets_on_chance_id"
    t.index ["user_id", "chance_id"], name: "index_bets_on_user_id_and_chance_id", unique: true
  end

  create_table "chance_participations", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "chance_id", null: false
    t.bigint "participation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position", default: 0, null: false
    t.index ["chance_id", "participation_id"], name: "index_chance_participations_on_chance_id_and_participation_id", unique: true
    t.index ["participation_id"], name: "index_chance_participations_on_participation_id"
  end

  create_table "chances", charset: "utf8mb4", force: :cascade do |t|
    t.integer "bet_type"
    t.integer "rate", default: 1
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contests", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "refund"
    t.integer "status"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_contests_on_user_id"
  end

  create_table "members", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "participations", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "contest_id", null: false
    t.bigint "member_id", null: false
    t.integer "rank"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contest_id", "member_id"], name: "index_participations_on_contest_id_and_member_id", unique: true
    t.index ["member_id"], name: "index_participations_on_member_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
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
  add_foreign_key "chance_participations", "chances"
  add_foreign_key "chance_participations", "participations"
  add_foreign_key "contests", "users"
  add_foreign_key "participations", "contests"
  add_foreign_key "participations", "members"
end
