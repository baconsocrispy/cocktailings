class Portion < ApplicationRecord
  belongs_to :portionable, :polymorphic => true
  belongs_to :ingredient
  validates :amount,  comparison: { greater_than: 0 }
end