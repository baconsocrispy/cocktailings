class AddSlugToCabinets < ActiveRecord::Migration[7.0]
  def change
    add_column :cabinets, :slug, :string
    add_index :cabinets, :slug
  end
end
