class AddReferenceToPortions < ActiveRecord::Migration[7.0]
  def change
    add_reference :portions, :ingredient_id, index: true
  end
end
