class RenameTableRecipesCategoriesAgain < ActiveRecord::Migration[7.0]
  def change
    rename_table :recipes_categories, :categories_recipes
  end
end
