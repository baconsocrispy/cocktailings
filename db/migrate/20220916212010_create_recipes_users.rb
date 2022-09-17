class CreateRecipesUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes_users do |t|
      t.belongs_to :recipe
      t.belongs_to :user
      
      t.timestamps
    end
  end
end
