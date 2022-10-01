class AddPortionableToPortion < ActiveRecord::Migration[7.0]
  def change
    add_reference :portions, :portionable, polymorphic: true, index: true
  end
end
