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

ActiveRecord::Schema[7.0].define(version: 2022_09_27_011024) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cabinets", force: :cascade do |t|
    t.string "name"
    t.boolean "locked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cabinets_on_name"
  end

  create_table "cabinets_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "cabinet_id", null: false
    t.index ["cabinet_id", "user_id"], name: "index_cabinets_users_on_cabinet_id_and_user_id"
    t.index ["user_id", "cabinet_id"], name: "index_cabinets_users_on_user_id_and_cabinet_id"
  end

  create_table "garnishes", force: :cascade do |t|
    t.string "garnish_type"
    t.decimal "amount"
    t.boolean "edible"
    t.string "brand"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "garnishable_type"
    t.bigint "garnishable_id"
    t.index ["garnishable_type", "garnishable_id"], name: "index_garnishes_on_garnishable"
  end

  create_table "mixers", force: :cascade do |t|
    t.string "mixer_type"
    t.string "brand"
    t.string "product"
    t.decimal "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mixable_type"
    t.bigint "mixable_id"
    t.decimal "amount"
    t.index ["mixable_type", "mixable_id"], name: "index_mixers_on_mixable"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes_users", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipes_users_on_recipe_id"
    t.index ["user_id"], name: "index_recipes_users_on_user_id"
  end

  create_table "spirits", force: :cascade do |t|
    t.string "spirit_type", null: false
    t.string "brand"
    t.string "product"
    t.decimal "abv"
    t.integer "age"
    t.decimal "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "spiritable_type"
    t.bigint "spiritable_id"
    t.decimal "amount"
    t.index ["spiritable_type", "spiritable_id"], name: "index_spirits_on_spiritable"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.text "description"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_steps_on_recipe_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "tool_type"
    t.string "brand"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "toolable_type"
    t.bigint "toolable_id"
    t.index ["toolable_type", "toolable_id"], name: "index_tools_on_toolable"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.date "dob"
    t.boolean "sober"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "steps", "recipes"
end
