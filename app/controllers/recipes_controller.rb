class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # handles favoriting/unfavoriting
  # POST /recipes/1/favorite
  def favorite
    set_recipe
    if current_user.favorites.include?(@recipe)
      current_user.favorites.delete(@recipe)
      render partial: 'unfavorite', locals: { recipe: @recipe }
    else
      current_user.favorites << @recipe
      render partial: 'favorite', locals: { recipe: @recipe }
    end
  end

  # GET /recipes/favorites
  def favorites
    @favorites = current_user.favorites
    respond_to do |format|
      format.html { render :favorites_index }
    end
  end

  # GET /recipes or /recipes.json
  def index
    category_id = params[:categoryId].to_i
    ingredient_ids = params[:ingredientIds]
    
    @page = params[:page].to_i || 1
    @recipes = Recipe.alphabetical.page(@page)

    case params[:sort_option]
    when ""
      params[:ingredientIds] ?
        @recipes = Recipe.alphabetical.filter_all_recipes(ingredient_ids, category_id).page(@page):
        @recipes = Recipe.filter_all_by_category(category_id).page(@page)
      respond_to do |format|
        format.html { render partial: 'recipe_cards', locals: { recipes: @recipes }}
        format.turbo_stream # { render 'index', locals: {recipes: @recipes }}
      end
    when 'All Recipes'
      params[:ingredientIds] ?
        @recipes = Recipe.alphabetical.filter_all_recipes(ingredient_ids, category_id).page(@page) :
        @recipes = Recipe.filter_all_by_category(category_id).page(@page)
      render partial: 'recipe_cards', locals: { recipes: @recipes }
    when 'Any Ingredient'
      params[:ingredientIds] ?
        @recipes = Recipe.alphabetical.match_any_subset(ingredient_ids, current_user.ingredients, category_id).page(@page) :
        @recipes = Recipe.alphabetical.match_any_ingredient(current_user.ingredients, category_id).page(@page)
      render partial: 'recipe_cards', locals: { recipes: @recipes }
    when 'All Ingredients'
      params[:ingredientIds] ?
        @recipes = Recipe.match_all_subset(params[:recipeIds], ingredient_ids, category_id).page(@page) :
        @recipes = Recipe.alphabetical.match_all_ingredients(current_user.ingredients, category_id).take(25)
      render partial: 'recipe_cards', locals: { recipes: @recipes }
    end
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @recipe.steps.build
    @recipe.portions.build
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    respond_to do |format|
      begin 
        @recipe.save!
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      rescue ActiveRecord::RecordNotUnique => e
        flash[:error] = "Recipe name already in use"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      rescue => e
        flash[:error] = e.message
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      # process_portions method explained in application_controller.rb
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.portions.destroy_all
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      # need to explicitly include :id for :steps/:portions for :_destroy to work
      params.require(:recipe).permit(:name, :description, :image, category_ids: [],
                                     steps_attributes: [:id,
                                                        :ingredient_id,
                                                        :name,
                                                        :description,
                                                        :_destroy
                                                        ],
                                     portions_attributes: [:id,
                                                           :ingredient_id,
                                                           :amount,
                                                           :unit,
                                                           :portionable_type,
                                                           :portionable_id,
                                                           :_destroy])                      
    end
end
