class CreateRecipeCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_categories do |t|

      t.timestamps
    end
  end
end
