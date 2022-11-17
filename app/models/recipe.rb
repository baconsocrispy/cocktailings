class Recipe < ApplicationRecord
  include Portionable
  
  has_one_attached :image
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tools
  has_and_belongs_to_many :categories
  has_many :ingredients, through: :portions
  has_many :steps, dependent: :destroy
  has_many :favorite_recipes
  has_many :favorited_by, through: :favorite_recipes, source: :user

  # add most_recent, popular (favorited?/viewed?), highest_rated, difficulty
  scope :alphabetical, -> { order(:name) }
  scope :by_category, -> (category_ids) { joins(:categories).where(categories: { id: category_ids })}
  scope :by_ingredient, -> (ingredient_ids) { joins(:ingredients).where(ingredients: { id: ingredient_ids })}
  scope :by_category_and_ingredient, -> (category_ids, ingredient_ids) { by_category(category_ids).by_ingredient(ingredient_ids).distinct }
  scope :search2, -> (query) { where('recipes.name ILIKE ?', "%#{ query }%").or(where('ingredients.display_name ILIKE ?', "%#{ query }%")) }

  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :categories_recipes, allow_destroy: false
  accepts_nested_attributes_for :portions, allow_destroy: true, reject_if: proc { |att| att['ingredient_id'].blank? }

  validates :name, presence: true

  # -------------- RECIPE SEARCH / FILTERING LOGIC --------------- #

  def self.search_recipes(search_params, user)
    sort_option = search_params[:sortOption]
    category_ids = search_params[:categoryIds] ? search_params[:categoryIds] : Category.all.map(&:id)
    ingredient_ids = search_params[:ingredientIds]
    search_term = search_params[:searchTerm]

    case sort_option
    when 'All Recipes'
      ingredient_ids ? 
        match_ingredients(category_ids, ingredient_ids)
          .search(search_term) :
        by_category(category_ids)
          .search(search_term)
    when 'I Have Any Ingredient'
      ingredient_ids ?
        match_any_subset(category_ids, user.ingredients, ingredient_ids)
          .search(search_term) :
        by_category_and_ingredient(category_ids, user.ingredients)
          .search(search_term)
    when 'I Have All Ingredients'
      ingredient_ids ?
        match_all_subset(category_ids, user.ingredients, ingredient_ids)
          .search(search_term) :
        user_has_all_ingredients(category_ids, user.ingredients)
          .search(search_term)
    when 'Favorites'
      ingredient_ids ?
        user.favorites.match_ingredients(category_ids, ingredient_ids)
          .search(search_term) :
        user.favorites.by_category(category_ids)
          .search(search_term)
    when 'My Recipes'
      ingredient_ids ?
        user.recipes.match_ingredients(category_ids, ingredient_ids)
          .search(search_term) :
        user.recipes.by_category(category_ids)
          .search(search_term)
    end
  end

  def self.search(query)
    joins(:ingredients).scoping do
      where('ingredients.display_name ILIKE ?', "%#{ query }%")
      .or(where('recipes.name ILIKE ?', "%#{ query }%"))
      .distinct
    end
  end

  # returns the set of recipes from all recipes that can be
  # made from any of the ingredients in the array
  def self.match_ingredients(category_ids, ingredient_ids)
    ingredient_ids = '{' + ingredient_ids.join(', ') + '}'
    by_category(category_ids)
      .joins(:ingredients)
      .group(:id)
      .having('array_agg(ingredients.id) @> ?', ingredient_ids)
  end

  # returns all recipes that match ANY of the user's ingredients and then 
  # filters those down to those matching ingredients selected from the cabinet
  def self.match_any_subset(category_ids, primary_ingredient_ids, subset_ids)
    subset_ids = '{' + subset_ids.join(', ') + '}'
    by_category_and_ingredient(category_ids, primary_ingredient_ids)
      .group(:id)
      .having('array_agg(ingredients.id) @> ?', subset_ids)
  end

  # returns all recipes that the user has all the ingredients for
  def self.user_has_all_ingredients(category_ids, user_ingredients)
    # casts user_ingredients to postgres array syntax
    user_ingredients = '{' + user_ingredients.join(', ') + '}'
    by_category(category_ids)
      .joins(:ingredients)
      .group(:id)
      .having('array_agg(ingredients.id) <@ ?', user_ingredients)
  end

  # returns all recipes that the user has ALL the ingredients for and then
  # filters those down to those matching ingredients selected from the cabinet
  def self.match_all_subset(category_ids, primary_ingredient_ids, subset_ids)
    subset_ids = '{' + subset_ids.join(', ') + '}'
    user_has_all_ingredients(category_ids, primary_ingredient_ids)
      .group(:id)
      .having('array_agg(ingredients.id) @> ?', subset_ids)
  end
end
