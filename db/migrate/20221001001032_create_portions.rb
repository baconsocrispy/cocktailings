class CreatePortions < ActiveRecord::Migration[7.0]
  def change
    create_table :portions do |t|
      t.decimal :amount
      t.string :unit

      t.timestamps
    end
  end
end
