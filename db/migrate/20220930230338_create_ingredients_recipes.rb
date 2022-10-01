class CreateIngredientsRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients_recipes do |t|
      t.belongs_to :ingredient
      t.belongs_to :recipe

      t.timestamps
    end
  end
end
