class FixCabinetNameError < ActiveRecord::Migration[7.0]
  def change
    remove_index :cabinets, :user_id_id
    remove_column :cabinets, :user_id_id
    add_reference :cabinets, :user, index: true
  end
end
