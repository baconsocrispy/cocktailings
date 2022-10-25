class AddColumnsToRecipesCategories < ActiveRecord::Migration[7.0]
  def change
    drop_table :recipe_categories
    
  end
end
