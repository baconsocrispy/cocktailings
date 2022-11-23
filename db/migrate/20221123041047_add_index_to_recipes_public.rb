class AddIndexToRecipesPublic < ActiveRecord::Migration[7.0]
  def change
    add_index :recipes, :public
  end
end
