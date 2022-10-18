class RemoveNullFromPortionsAmount < ActiveRecord::Migration[7.0]
  def change
    change_column_null :portions, :amount, true
  end
end
