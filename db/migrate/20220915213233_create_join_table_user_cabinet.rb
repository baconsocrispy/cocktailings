class CreateJoinTableUserCabinet < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :cabinets do |t|
      t.index [:user_id, :cabinet_id]
      t.index [:cabinet_id, :user_id]
    end
  end
end
