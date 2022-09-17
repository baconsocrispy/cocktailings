class RenameColumnQuantityRecipe < ActiveRecord::Migration[7.0]
  def change
    rename_column :garnishes, :quantity, :amount
    add_column :spirits, :amount, :decimal
    add_column :mixers, :amount, :decimal
  end
end
