class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :dob
      t.boolean :sober

      t.timestamps
    end
    add_index :users, :email
  end
end
