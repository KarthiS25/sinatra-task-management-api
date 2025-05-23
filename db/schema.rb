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

ActiveRecord::Schema[7.2].define(version: 2025_04_24_110914) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "task_managements", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id"
    t.string "job_id"
    t.index ["user_id"], name: "index_task_managements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "age"
    t.string "dob"
    t.string "phone_number"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
