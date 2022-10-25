class Category < ApplicationRecord
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories, source: :recipe
  validates :name, uniqueness: true, presence: true
end
