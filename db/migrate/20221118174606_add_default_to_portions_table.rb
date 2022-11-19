class AddDefaultToPortionsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :portions, :optional, :boolean, default: false, null: false

    add_index :portions, :optional
  end
end
