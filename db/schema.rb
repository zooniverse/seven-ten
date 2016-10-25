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

ActiveRecord::Schema.define(version: 20161021145820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_requests", force: :cascade do |t|
    t.integer  "split_id",                       null: false
    t.string   "state",      default: "pending"
    t.string   "url"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["split_id"], name: "index_data_requests_on_split_id", using: :btree
  end

  create_table "metrics", force: :cascade do |t|
    t.integer  "split_user_variant_id",              null: false
    t.string   "key",                                null: false
    t.json     "value",                 default: {}
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["key"], name: "index_metrics_on_key", using: :btree
    t.index ["split_user_variant_id"], name: "index_metrics_on_split_user_variant_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string "slug"
    t.index ["slug"], name: "index_projects_on_slug", unique: true, using: :btree
  end

  create_table "split_user_variants", force: :cascade do |t|
    t.integer  "split_id",   null: false
    t.integer  "user_id",    null: false
    t.integer  "variant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["split_id", "user_id"], name: "index_split_user_variants_on_split_id_and_user_id", unique: true, using: :btree
    t.index ["split_id"], name: "index_split_user_variants_on_split_id", using: :btree
    t.index ["user_id"], name: "index_split_user_variants_on_user_id", using: :btree
    t.index ["variant_id"], name: "index_split_user_variants_on_variant_id", using: :btree
  end

  create_table "splits", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "key",                               null: false
    t.string   "state",        default: "inactive", null: false
    t.integer  "project_id",                        null: false
    t.datetime "ends_at",                           null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "metric_types", default: [],                      array: true
    t.index ["key", "state", "project_id"], name: "index_splits_on_key_and_state_and_project_id", unique: true, where: "((state)::text = 'active'::text)", using: :btree
    t.index ["project_id"], name: "index_splits_on_project_id", using: :btree
    t.index ["state"], name: "index_splits_on_state", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.index ["login"], name: "index_users_on_login", using: :btree
  end

  create_table "variants", force: :cascade do |t|
    t.string   "name",       null: false
    t.json     "value",      null: false
    t.integer  "split_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["split_id"], name: "index_variants_on_split_id", using: :btree
  end

  add_foreign_key "data_requests", "splits", on_delete: :cascade
  add_foreign_key "metrics", "split_user_variants", on_delete: :cascade
  add_foreign_key "split_user_variants", "splits", on_delete: :cascade
  add_foreign_key "split_user_variants", "users"
  add_foreign_key "split_user_variants", "variants", on_delete: :cascade
  add_foreign_key "splits", "projects"
  add_foreign_key "variants", "splits", on_delete: :cascade
end
