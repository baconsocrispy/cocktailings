class Ingredient < ApplicationRecord
  has_and_belongs_to_many :recipes
  has_many :portions
  validates :display_name, presence: true
  validates :display_name, uniqueness: true
  validates :sub_type, presence: true
end
