class UpdateReferencePortions < ActiveRecord::Migration[7.0]
  def change
    remove_column :portions, :ingredient_id
    add_reference :portions, :ingredient, index: true
  end
end
