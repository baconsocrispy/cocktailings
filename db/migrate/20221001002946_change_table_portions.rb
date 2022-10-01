class ChangeTablePortions < ActiveRecord::Migration[7.0]
  def change
    add_column :portions, :ingredient_id, :integer, belongs_to: :ingredient, foreign_key: true, null: false
  end
end
