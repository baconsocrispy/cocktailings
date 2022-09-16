class CreateCabinets < ActiveRecord::Migration[7.0]
  def change
    create_table :cabinets do |t|
      t.string :name
      t.boolean :locked

      t.timestamps
    end
    add_index :cabinets, :name
  end
end
