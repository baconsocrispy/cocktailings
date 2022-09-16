class CreateSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :steps do |t|
      t.integer :number
      t.string :name
      t.text :description
      t.belongs_to :recipe

      t.timestamps
    end
    add_foreign_key :steps, :recipes, column: :recipe_id
  end
end
