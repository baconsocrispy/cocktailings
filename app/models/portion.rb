class Portion < ApplicationRecord
  belongs_to :portionable, :polymorphic => true
  belongs_to :ingredient
end
