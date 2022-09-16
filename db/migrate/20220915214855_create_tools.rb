class CreateTools < ActiveRecord::Migration[7.0]
  def change
    create_table :tools do |t|
      t.string :type
      t.string :brand
      t.text :description
      t.belongs_to :cabinet

      t.timestamps
    end
  end
end
