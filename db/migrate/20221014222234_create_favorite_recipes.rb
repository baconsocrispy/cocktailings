class CreateFavoriteRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_recipes do |t|
      t.integer :recipe_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
