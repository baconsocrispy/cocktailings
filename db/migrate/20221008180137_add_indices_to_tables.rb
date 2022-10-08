class AddIndicesToTables < ActiveRecord::Migration[7.0]
  def change
    change_column_null :ingredients, :display_name, false
    change_column_null :ingredients, :sub_type, false
    change_column_null :portions, :portionable_id, false
    change_column_null :portions, :portionable_type, false
    change_column_null :steps, :name, false
    change_column_null :steps, :recipe_id, false
  end
end
