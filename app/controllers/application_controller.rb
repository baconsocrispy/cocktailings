class ApplicationController < ActionController::Base
  def add_ingredients_to_recipe(recipe, recipe_params)
    ingredient_ids = recipe_params[:ingredient_id]
    ingredient_ids.each { |id| recipe.ingredients << Ingredient.find(id) if id != "" }
  end
end
