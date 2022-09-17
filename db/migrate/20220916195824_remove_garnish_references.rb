class RemoveGarnishReferences < ActiveRecord::Migration[7.0]
  def change
    change_table :garnishes do |t|
      t.remove_references :cabinet
    end
  end
end
