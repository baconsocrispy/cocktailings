class CreateUsersRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :users_recipes do |t|
      t.belongs_to :user
      t.belongs_to :recipe

      t.timestamps
    end
  end
end
