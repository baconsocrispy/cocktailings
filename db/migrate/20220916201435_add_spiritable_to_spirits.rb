class AddSpiritableToSpirits < ActiveRecord::Migration[7.0]
  def change
    add_reference :spirits, :spiritable, polymorphic: true, index: true
  end
end
