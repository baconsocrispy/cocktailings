class RemoveForeignKeyRecipesUsers < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :recipes, :users
  end
end
