class CreateSpirits < ActiveRecord::Migration[7.0]
  def change
    create_table :spirits do |t|
      t.string :spirit_type, null: false
      t.string :brand, null: false
      t.string :product
      t.decimal :abv
      t.integer :age
      t.decimal :size
      t.belongs_to :cabinet

      t.timestamps
    end
    add_foreign_key :spirits, :cabinets, column: :cabinet_id
  end
end
