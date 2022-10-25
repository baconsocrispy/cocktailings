class CreateRecipeCategoryTable < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes_categories do |t|
      t.belongs_to :recipe, index: true, foreign_key: true
      t.belongs_to :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
