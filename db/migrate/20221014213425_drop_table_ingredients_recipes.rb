class DropTableIngredientsRecipes < ActiveRecord::Migration[7.0]
  def change
    drop_table :ingredients_recipes
  end
end
