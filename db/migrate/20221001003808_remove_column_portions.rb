class RemoveColumnPortions < ActiveRecord::Migration[7.0]
  def change
    remove_column :portions, :ingredient_id_id
  end
end
