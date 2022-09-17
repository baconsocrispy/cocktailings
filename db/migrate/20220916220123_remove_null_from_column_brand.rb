class RemoveNullFromColumnBrand < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:spirits, :brand, true)
  end
end
