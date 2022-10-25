class Recipe < ApplicationRecord
  include Toolable
  include Portionable
  
  has_one_attached :image
  has_and_belongs_to_many :users
  has_and_belongs_to_many :categories
  has_many :ingredients, through: :portions
  has_many :steps, dependent: :destroy
  has_many :favorite_recipes
  has_many :favorited_by, through: :favorite_recipes, source: :user

  # add most_recent, popular (favorited?/viewed?), highest_rated
  scope :alphabetical, -> { order(:name) }

  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :categories_recipes, allow_destroy: false
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
  def self.match_any_ingredient(ingredient_ids)
    recipes = Recipe.joins(:portions)
                    .where(portions: { ingredient_id: ingredient_ids })
                    .distinct            
    return recipes
  end

  # filters results from match any to those that have all the selected
  # ingredients from liquor cabinet display
  def self.match_any_subset(selected_ingredient_ids, user_ingredient_ids)
    recipes = match_any_ingredient(user_ingredient_ids)
    recipes = recipes.filter_all_recipes(selected_ingredient_ids)
    return recipes
  end

  # returns the set of recipes from all recipes that can be
  # made from all of the ingredients in the array. N + 1. TOO SLOW.
  def self.match_all_ingredients(ingredient_ids)
    recipes = match_any_ingredient(ingredient_ids)     
                .joins(:portions => :ingredient)
                .group(:id)
                .select { |r| (r.ingredient_ids - ingredient_ids).empty? }
    return recipes
  end

  # works fast  but probably not the best implementation
  def self.match_all_subset(recipe_ids, ingredient_ids)
    recipes = Recipe.where(:id => recipe_ids)
                    .joins(:portions)
                    .where(portions: { ingredient_id: ingredient_ids})
                    .group(:id)
                    .having('count(distinct portions.ingredient_id) = ?', ingredient_ids.size)
    return recipes
  end
end
