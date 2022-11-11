class RemoveColumnsFromTools < ActiveRecord::Migration[7.0]
  def change
    remove_index :tools, name: "index_tools_on_toolable"
    remove_column :tools, :toolable_type
    remove_column :tools, :toolable_id
  end
end
