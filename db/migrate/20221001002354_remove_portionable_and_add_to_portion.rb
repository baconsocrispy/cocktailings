class RemovePortionableAndAddToPortion < ActiveRecord::Migration[7.0]
  def change
    remove_reference :recipes, :portionable, polymorphic: true, index: true
    remove_reference :cabinets, :portionable, polymorphic: true, index: true
  end
end
