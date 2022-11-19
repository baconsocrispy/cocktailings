class ChangeColumnNullAndDefaultPortions < ActiveRecord::Migration[7.0]
  def change
    change_column_null :portions, :optional, null: true
    change_column_default :portions, :optional, from: false, to: nil
  end
end
