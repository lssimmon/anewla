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

ActiveRecord::Schema[8.1].define(version: 2026_11_12_000000) do
  create_table "todos", force: :cascade do |t|
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "due_date"
    t.integer "priority"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  create_table "weight_entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "recorded_on", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.decimal "weight", precision: 8, scale: 2, null: false
    t.index ["user_id", "recorded_on"], name: "index_weight_entries_on_user_id_and_recorded_on"
    t.index ["user_id"], name: "index_weight_entries_on_user_id"
  end

  add_foreign_key "todos", "users"
  add_foreign_key "weight_entries", "users"
end
