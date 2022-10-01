class Ingredient < ApplicationRecord
  has_and_belongs_to_many :recipes
  has_and_belongs_to_many :users
  has_and_belongs_to_many :portions
end
