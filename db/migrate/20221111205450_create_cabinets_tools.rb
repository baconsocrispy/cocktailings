class CreateCabinetsTools < ActiveRecord::Migration[7.0]
  def change
    create_table :cabinets_tools do |t|
      t.belongs_to :cabinet, index: true, foreign_key: true, null: false
      t.belongs_to :tool, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
