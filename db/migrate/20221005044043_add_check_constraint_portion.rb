class AddCheckConstraintPortion < ActiveRecord::Migration[7.0]
  def change
    execute "ALTER TABLE portions ADD CONSTRAINT amount_check CHECK (amount > 0)"
  end
end
