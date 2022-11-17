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

  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :categories_recipes, allow_destroy: false
  accepts_nested_attributes_for :portions, allow_destroy: true, reject_if: proc { |att| att['ingredient_id'].blank? }

  validates :name, presence: true

  # ordering scopes
  scope :alphabetical, -> { order(:name) }

  # filtering scopes
  scope :search, lambda{ |search_term| self.where('name ILIKE ?', "%#{ search_term }%").distinct if search_term.present? }
  scope :by_category, lambda{ |category_ids| self.joins(:categories).where(categories: { id: category_ids }) if category_ids.present? }
  scope :by_all_ingredients, lambda{ |ingredient_ids| self.joins(:ingredients).group(:id).having('array_agg(ingredients.id) @> ?', ingredient_ids) if ingredient_ids.present? }
  scope :by_any_ingredient, lambda{ |ingredient_ids| self.joins(:ingredients).where(ingredients: { id: ingredient_ids }).distinct }
  scope :user_has_all_ingredients, lambda{ |user_ingredients| self.joins(:ingredients).group(:id).having('array_agg(ingredients.id) <@ ?', user_ingredients) if user_ingredients.present? }

  def self.search_recipes(search_params, user)
    sort_option = search_params[:sortOption]
    category_ids = search_params[:categoryIds]
    search_term = search_params[:searchTerm]

    # needed to cast these into Postgres array format in order to function properly
    ingredient_ids = '{' + search_params[:ingredientIds].join(', ') + '}' if search_params[:ingredientIds]
    user_ingredients = '{' + user.ingredients.join(', ') + '}'

    case sort_option
    when 'All Recipes'
      by_category(category_ids)
        .by_all_ingredients(ingredient_ids)
        .search(search_term)
    when 'I Have Any Ingredient' 
      by_category(category_ids)
        .by_any_ingredient(user.ingredients)
        .by_all_ingredients(ingredient_ids)
        .search(search_term)
    when 'I Have All Ingredients'
      by_category(category_ids)
        .user_has_all_ingredients(user_ingredients)
        .by_all_ingredients(ingredient_ids)
        .search(search_term)
    when 'Favorites'
      user.favorites
        .by_category(category_ids)
        .by_all_ingredients(ingredient_ids)
        .search(search_term)
    when 'My Recipes'
      user.recipes
        .by_category(category_ids)
        .by_all_ingredients(ingredient_ids)
        .search(search_term)
    end
  end
end
