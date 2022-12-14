class Category < ApplicationRecord
  has_and_belongs_to_many :recipes
  validates :name, uniqueness: true, presence: true
end
