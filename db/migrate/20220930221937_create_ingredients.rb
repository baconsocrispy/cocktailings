class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :display_name
      t.string :sub_type
      t.string :brand
      t.string :product
      t.decimal :abv
      t.integer :age
      t.integer :size
      t.decimal :amount

      t.timestamps
    end
  end
end
