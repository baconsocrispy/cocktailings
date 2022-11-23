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

ActiveRecord::Schema[7.0].define(version: 2022_11_23_041047) do
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
    t.string "name", null: false
    t.boolean "locked", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "slug"
    t.index ["name"], name: "index_cabinets_on_name"
    t.index ["slug"], name: "index_cabinets_on_slug"
    t.index ["user_id"], name: "index_cabinets_on_user_id"
  end

  create_table "cabinets_tools", force: :cascade do |t|
    t.bigint "cabinet_id", null: false
    t.bigint "tool_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cabinet_id"], name: "index_cabinets_tools_on_cabinet_id"
    t.index ["tool_id"], name: "index_cabinets_tools_on_tool_id"
  end

  create_table "cabinets_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "cabinet_id", null: false
    t.index ["cabinet_id", "user_id"], name: "index_cabinets_users_on_cabinet_id_and_user_id"
    t.index ["user_id", "cabinet_id"], name: "index_cabinets_users_on_user_id_and_cabinet_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "categories_recipes", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_recipes_on_category_id"
    t.index ["recipe_id", "category_id"], name: "index_categories_recipes_on_recipe_id_and_category_id", unique: true
    t.index ["recipe_id"], name: "index_categories_recipes_on_recipe_id"
  end

  create_table "favorite_recipes", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "display_name", null: false
    t.string "sub_type", null: false
    t.string "brand"
    t.string "product"
    t.decimal "abv"
    t.integer "age"
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

  create_table "portions", force: :cascade do |t|
    t.decimal "amount"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "portionable_type", null: false
    t.bigint "portionable_id", null: false
    t.bigint "ingredient_id", null: false
    t.boolean "optional"
    t.index ["ingredient_id"], name: "index_portions_on_ingredient_id"
    t.index ["optional"], name: "index_portions_on_optional"
    t.index ["portionable_type", "portionable_id"], name: "index_portions_on_portionable"
    t.check_constraint "amount > 0::numeric", name: "amount_check"
  end

  create_table "recipes", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "slug"
    t.boolean "public", default: false
    t.index ["name"], name: "index_recipes_on_name", unique: true
    t.index ["public"], name: "index_recipes_on_public"
    t.index ["slug"], name: "index_recipes_on_slug"
  end

  create_table "recipes_tools", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "tool_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipes_tools_on_recipe_id"
    t.index ["tool_id"], name: "index_recipes_tools_on_tool_id"
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
    t.integer "position"
    t.index ["recipe_id"], name: "index_steps_on_recipe_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "tool_type"
    t.string "brand"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "default_cabinet"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cabinets_tools", "cabinets"
  add_foreign_key "cabinets_tools", "tools"
  add_foreign_key "categories_recipes", "categories"
  add_foreign_key "categories_recipes", "recipes"
  add_foreign_key "recipes_tools", "recipes"
  add_foreign_key "recipes_tools", "tools"
  add_foreign_key "steps", "recipes"
end
