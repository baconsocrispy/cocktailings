class DropSpirits < ActiveRecord::Migration[7.0]
  def change
    drop_table :spirits
    drop_table :garnishes
    drop_table :mixers
  end
end
