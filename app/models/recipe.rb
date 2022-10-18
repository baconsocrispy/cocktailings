class Recipe < ApplicationRecord
  include Toolable
  include Portionable
  
  has_one_attached :image
  has_and_belongs_to_many :users
  has_many :ingredients, through: :portions
  has_many :steps, dependent: :destroy
  has_many :favorite_recipes
  has_many :favorited_by, through: :favorite_recipes, source: :user

  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :portions, allow_destroy: true, reject_if: proc { |att| att['ingredient_id'].blank? }

  validates :name, presence: true

  def self.possible_recipes(ingredients_hash)
    recipes = []
    Recipe.all.each do |r|
      missing_ingredients = 0
      r.ingredients.each do |i|
        missing_ingredients += 1 if !ingredients_hash[i.id]
      end
      recipes << r if missing_ingredients == 0
    end
    return recipes
  end
end
