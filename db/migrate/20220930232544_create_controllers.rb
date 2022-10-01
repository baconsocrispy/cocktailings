class CreateControllers < ActiveRecord::Migration[7.0]
  def change
    create_table :controllers do |t|
      t.string :Ingredients

      t.timestamps
    end

    drop_table :controllers
  end
end
