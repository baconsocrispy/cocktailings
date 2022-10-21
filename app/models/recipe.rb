class Recipe < ApplicationRecord
  include Toolable
  include Portionable
  
  has_one_attached :image
  has_and_belongs_to_many :users
  has_many :ingredients, through: :portions
  has_many :steps, dependent: :destroy
  has_many :favorite_recipes
  has_many :favorited_by, through: :favorite_recipes, source: :user

  scope :alphabetical, -> { order(:name) }

  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :portions, allow_destroy: true, reject_if: proc { |att| att['ingredient_id'].blank? }

  validates :name, presence: true


  # -------------- RECIPE FILTERING LOGIC BELOW --------------- #

  # returns a set of recipes from all recipes filtered by options
  # selected in the liquor cabinet display widget
   def self.filter_all_recipes(ingredients_array)
    recipes = Recipe.joins(:portions) # joins recipe & portion tables
                    .where(portions: { ingredient_id: ingredients_array }) # reduces to only portions that have an ingredient_id in the array
                    .group(:id) # groups results by recipe id
                    .having('count(distinct portions.ingredient_id) = ?', ingredients_array.size) # only includes matching recipe ids where there are as many unique ids as the input array
    return recipes
  end
  
  # returns the set of recipes from all recipes that can be
  # made from any of the ingredients in the array
  def self.match_any_ingredient(ingredients_array)
    recipes = Recipe.includes(:portions)
                    .where(portions: { ingredient_id: ingredients_array })
    return recipes
  end
  
  # returns the set of recipes from all recipes that can be
  # made from all of the ingredients in the array
  def self.match_all_ingredients(ingredients_array)
    all_recipes = []
    any_recipes = match_any_ingredient(ingredients_array)
    any_recipes.each do |r|
      all_recipes << r if (r.ingredients.map(&:id) - ingredients_array).empty?
    end
    return all_recipes
  end

  def self.match_all_subset(ingredients_array, subset_array)
    subset = []
    match_all = match_all_ingredients(ingredients_array)
    match_all.each do |r|
      ingredients = r.ingredients.map(&:id)
      subset << r if ingredients.any? { |id| subset_array.include?(id.to_s) }
    end
    return subset
  end

  private
  def self.get_recipe_ids(recipes)
    ids = []
    recipes.each { |r| ids << r.id }
    return ids
  end
end
