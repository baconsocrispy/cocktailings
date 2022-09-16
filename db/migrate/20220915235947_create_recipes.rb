class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.integer :author_id
      t.text :description

      t.timestamps
    end
    add_foreign_key :recipes, :users, column: :author_id
  end
end
