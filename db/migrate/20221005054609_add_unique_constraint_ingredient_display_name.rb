class AddUniqueConstraintIngredientDisplayName < ActiveRecord::Migration[7.0]
  def change
    add_index :ingredients, :display_name, unique: true
  end
end
