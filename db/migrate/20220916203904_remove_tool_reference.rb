class RemoveToolReference < ActiveRecord::Migration[7.0]
  def change
    change_table :tools do |t|
      t.remove_references :cabinet
    end
  end
end
