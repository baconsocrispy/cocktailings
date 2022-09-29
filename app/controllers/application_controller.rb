class ApplicationController < ActionController::Base
  def process_ingredients(recipe, recipe_params)
    spirit_ids = recipe_params[:spirit_id]
    mixer_ids = recipe_params[:mixer_id]
    garnish_ids = recipe_params[:garnish_id]

    spirit_ids.each { |id| recipe.spirits << Spirit.find(id) if id != "" }
    mixer_ids.each { |id| recipe.mixers << Mixer.find(id) if id != "" }
    garnish_ids.each { |id| recipe.garnishes << Garnish.find(id) if id != "" }
  end
end
