class AddColumnToCabinet < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :default_cabinet, :integer
  end
end
