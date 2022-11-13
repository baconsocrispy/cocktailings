class RenameTableRecipesCategories < ActiveRecord::Migration[7.0]
  def change
    rename_table :recipes_categories, :recipe_categories
  end
end
