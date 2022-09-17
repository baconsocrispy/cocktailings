class AddMixableToMixers < ActiveRecord::Migration[7.0]
  def change
    add_reference :mixers, :mixable, polymorphic: true, index: true
  end
end
