class AddNotNullToRecipesCategories < ActiveRecord::Migration[7.0]
  def change
    change_column_null :recipes_categories, :recipe_id, false
    change_column_null :recipes_categories, :category_id, false

    add_index :recipes_categories, [:recipe_id, :category_id], unique: true
  end
end
