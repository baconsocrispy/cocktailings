class AddGarnishableToGarnish < ActiveRecord::Migration[7.0]
  def change
    add_reference :garnishes, :garnishable, polymorphic: true, index: true
  end
end
