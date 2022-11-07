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

  # add most_recent, popular (favorited?/viewed?), highest_rated, difficulty
  scope :alphabetical, -> { order(:name) }

  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :categories_recipes, allow_destroy: false
  accepts_nested_attributes_for :portions, allow_destroy: true, reject_if: proc { |att| att['ingredient_id'].blank? }

  validates :name, presence: true

  # -------------- RECIPE SEARCH / FILTERING LOGIC BELOW --------------- #

  def self.search(query)
    joins(:ingredients).scoping do
      where('recipes.name ILIKE ?', "%#{ query }%")
      .or(where('ingredients.display_name ILIKE ?', "%#{ query }%"))
      .distinct
    end
  end

  # filters all recipes by category
  def self.filter_all_by_category(category_id)
    Recipe.joins(:categories)
          .where(categories: { id: category_id })
  end

  # returns the set of recipes from all recipes that can be
  # made from any of the ingredients in the array
  def self.filter_all_recipes(ingredient_ids, category_id)
    ingredient_ids = '{' + ingredient_ids.join(', ') + '}'
    Recipe.filter_all_by_category(category_id)
          .joins(:ingredients)
          .group(:id)
          .having('array_agg(ingredients.id) @> ?', ingredient_ids)
  end

  # returns the set of recipes from all recipes that can be
  # made from any of the ingredients in the array
  def self.user_has_any_ingredient(ingredient_ids, category_id)
    Recipe.filter_all_by_category(category_id)
          .joins(:ingredients)
          .where(ingredients: { id: ingredient_ids })
          .distinct
  end

  # returns all recipes that match ANY of the user's ingredients and then 
  # filters those down to those matching ingredients selected from the cabinet
  def self.match_any_subset(subset_ids, primary_ingredient_ids, category_id)
    subset_ids = '{' + subset_ids.join(', ') + '}'
    Recipe.user_has_any_ingredient(primary_ingredient_ids, category_id)
          .group(:id)
          .having('array_agg(ingredients.id) @> ?', subset_ids)
  end

  # returns all recipes that the user has all the ingredients for
  def self.user_has_all_ingredients(ingredient_ids, category_id)
    # casts ingredient_ids to postgres array syntax
    ingredient_ids = '{' + ingredient_ids.join(', ') + '}'
    Recipe.filter_all_by_category(category_id)
          .joins(:ingredients)
          .group(:id)
          .having('array_agg(ingredients.id) <@ ?', ingredient_ids)
  end

  # returns all recipes that the user has ALL the ingredients for and then
  # filters those down to those matching ingredients selected from the cabinet
  def self.match_all_subset(subset_ids, primary_ingredient_ids, category_id)
    subset_ids = '{' + subset_ids.join(', ') + '}'
    Recipe.user_has_all_ingredients(primary_ingredient_ids, category_id)
          .group(:id)
          .having('array_agg(ingredients.id) @> ?', subset_ids)
  end
end
