class AddForeignKeyToToolsTable < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :tools, :cabinets, column: :cabinet_id
  end
end
