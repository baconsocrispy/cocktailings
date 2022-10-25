class Category < ApplicationRecord
  has_and_belongs_to_many :recipes, join_table: "recipe_categories", foreign_key: "recipe_id"
  validates :name, uniqueness: true, presence: true
end
