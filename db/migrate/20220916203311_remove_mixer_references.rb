class RemoveMixerReferences < ActiveRecord::Migration[7.0]
  def change
    change_table :mixers do |t|
      t.remove_references :cabinet
    end
  end
end
