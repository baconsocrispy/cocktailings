class CreateIngredientsPortions < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients_portions do |t|
      t.belongs_to :ingredient
      t.belongs_to :portion

      t.timestamps
    end
  end
end
