class DropUsersRecipes < ActiveRecord::Migration[7.0]
  def change
    drop_table :users_recipes
  end
end
