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

ActiveRecord::Schema[7.0].define(version: 2022_10_14_172509) do
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

  create_table "ingredients", force: :cascade do |t|
    t.string "display_name", null: false
    t.string "sub_type", null: false
    t.string "brand"
    t.string "product"
    t.decimal "abv"
    t.integer "age"
    t.integer "size"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["display_name"], name: "index_ingredients_on_display_name", unique: true
  end

  create_table "ingredients_portions", force: :cascade do |t|
    t.bigint "ingredient_id"
    t.bigint "portion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_ingredients_portions_on_ingredient_id"
    t.index ["portion_id"], name: "index_ingredients_portions_on_portion_id"
  end

  create_table "ingredients_recipes", force: :cascade do |t|
    t.bigint "ingredient_id"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_ingredients_recipes_on_ingredient_id"
    t.index ["recipe_id"], name: "index_ingredients_recipes_on_recipe_id"
  end

  create_table "portions", force: :cascade do |t|
    t.decimal "amount", null: false
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "portionable_type", null: false
    t.bigint "portionable_id", null: false
    t.bigint "ingredient_id", null: false
    t.index ["ingredient_id"], name: "index_portions_on_ingredient_id"
    t.index ["portionable_type", "portionable_id"], name: "index_portions_on_portionable"
    t.check_constraint "amount > 0::numeric", name: "amount_check"
  end

  create_table "recipes", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["name"], name: "index_recipes_on_name", unique: true
  end

  create_table "recipes_users", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipes_users_on_recipe_id"
    t.index ["user_id"], name: "index_recipes_users_on_user_id"
  end

  create_table "steps", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "recipe_id", null: false
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
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "steps", "recipes"
end
