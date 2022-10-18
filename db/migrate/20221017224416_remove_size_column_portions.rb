class RemoveSizeColumnPortions < ActiveRecord::Migration[7.0]
  def change
    remove_column :portions, :size
  end
end
