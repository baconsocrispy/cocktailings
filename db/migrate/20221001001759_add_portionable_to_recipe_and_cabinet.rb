class AddPortionableToRecipeAndCabinet < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :portionable, polymorphic: true, index: true
    add_reference :cabinets, :portionable, polymorphic: true, index: true
  end
end
