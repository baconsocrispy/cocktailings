class AddToolableToTools < ActiveRecord::Migration[7.0]
  def change
    add_reference :tools, :toolable, polymorphic: true, index: true
  end
end
