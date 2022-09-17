class Garnish < ApplicationRecord
 belongs_to :garnishable, :polymorphic => true
end