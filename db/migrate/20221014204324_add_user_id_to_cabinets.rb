class AddUserIdToCabinets < ActiveRecord::Migration[7.0]
  def change
    change_column_null :cabinets, :name, false
    add_reference :cabinets, :user_id, index: true
    change_column_default :cabinets, :locked, true
  end
end
