class RemoveColumnsSizeAmountFromIngredients < ActiveRecord::Migration[7.0]
  def change
    remove_column :ingredients, :size
    remove_column :ingredients, :amount
    add_column :portions, :size, :decimal
  end
end
