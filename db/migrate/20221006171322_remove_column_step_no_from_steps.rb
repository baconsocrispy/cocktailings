class RemoveColumnStepNoFromSteps < ActiveRecord::Migration[7.0]
  def change
    remove_column :steps, :number
  end
end
