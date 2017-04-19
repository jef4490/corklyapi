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

ActiveRecord::Schema.define(version: 20170419042733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

  create_table "boards", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "elements", force: :cascade do |t|
    t.integer  "board_id"
    t.integer  "EID"
    t.integer  "x"
    t.integer  "y"
    t.integer  "height"
    t.integer  "width"
    t.text     "content"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "bgcolor"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "board_id"
    t.integer "account_id"
  end

end
