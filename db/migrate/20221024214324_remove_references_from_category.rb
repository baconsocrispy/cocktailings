class RemoveReferencesFromCategory < ActiveRecord::Migration[7.0]
  def change
    remove_reference :categories, :recipe
  end
end
