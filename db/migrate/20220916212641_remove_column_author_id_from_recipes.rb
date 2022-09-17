class RemoveColumnAuthorIdFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :author_id
  end
end
