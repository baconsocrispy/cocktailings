class DropAndAddColumnName < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :name
    add_column :recipes, :name, :string, null: false
  end
end
