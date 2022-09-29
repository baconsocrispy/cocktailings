class Garnish < ApplicationRecord
 belongs_to :garnishable, :polymorphic => true

 def to_s
  self.garnish_type
 end
end