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

  # returns the set of recipes from all recipes that can be
  # made from a user's liquor cabinet
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

  # returns a set of recipes from all recipes filtered by options
  # selected in the liquor cabinet display widget
  def self.filter_all_recipes(ingredients_array)
    ingredient_hash = convert_array_to_hash(ingredients_array)
    recipes = []
    Recipe.all.each do |r|
      included_ingredients = 0
      r.ingredients.each do |i|
        included_ingredients += 1 if ingredient_hash[i.id]
      end
      recipes << r if included_ingredients == ingredient_hash.length
    end
    return recipes
  end

  # returns a set of recipes filtered by all possible from cabinet ingredients
  # and then by options selected in the liquor cabinet display widget
  def self.filter_possible_recipes(ingredients_array, user_ingredients_hash)
    recipes = []
    ingredient_hash = convert_array_to_hash(ingredients_array)
    possible_recipes = Recipe.possible_recipes(user_ingredients_hash)
    possible_recipes.each do |r|
      included_ingredients = 0
      r.ingredients.each do |i|
        included_ingredients += 1 if ingredient_hash[i.id]
      end
      recipes << r if included_ingredients == ingredient_hash.length
    end
    return recipes
  end
    
  private
  def self.convert_array_to_hash(array)
    hash = {}
    array.each { |e| hash[e.to_i] = 1}
    return hash
  end
end
