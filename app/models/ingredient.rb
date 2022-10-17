class Ingredient < ApplicationRecord
  has_many :portions
  has_many :recipes, through: :portions
  has_many :cabinets, through: :portions
  validates :display_name, presence: true
  validates :display_name, uniqueness: true
  validates :sub_type, presence: true
end
