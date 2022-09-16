class CreateGarnishes < ActiveRecord::Migration[7.0]
  def change
    create_table :garnishes do |t|
      t.string :garnish_type
      t.integer :quantity
      t.boolean :edible
      t.string :brand
      t.belongs_to :cabinet

      t.timestamps
    end
    add_foreign_key :garnishes, :cabinets, column: :cabinet_id
  end
end
