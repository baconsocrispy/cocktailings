class ChangeColumnNullAmount < ActiveRecord::Migration[7.0]
  def change
    change_column_null :portions, :amount, false
  end
end
