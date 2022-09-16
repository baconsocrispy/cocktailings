class RenameColumnTypeInToolsTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :tools, :type, :tool_type
  end
end
