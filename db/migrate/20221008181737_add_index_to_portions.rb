class AddIndexToPortions < ActiveRecord::Migration[7.0]
  def change
    change_column_null :portions, :ingredient_id, false
  end
end
