class Portion < ApplicationRecord
  belongs_to :portionable, :polymorphic => true
  belongs_to :ingredient
  validates :ingredient_id, presence: true
  validates :portionable_id, presence: true
  validates :portionable_type, presence: true
  validates :amount, presence: true, comparison: { greater_than: 0 }, allow_blank: false
end