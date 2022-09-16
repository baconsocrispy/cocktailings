class CreateMixers < ActiveRecord::Migration[7.0]
  def change
    create_table :mixers do |t|
      t.string :mixer_type
      t.string :brand
      t.string :product
      t.decimal :size
      t.belongs_to :cabinet

      t.timestamps
    end
    add_foreign_key :mixers, :cabinets, column: :cabinet_id
  end
end
