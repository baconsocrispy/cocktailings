class AddTypeToIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :type, :string
  end
end
