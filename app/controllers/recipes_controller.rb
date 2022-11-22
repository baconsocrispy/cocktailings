class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # handles favoriting/unfavoriting
  # POST /recipes/1/favorite
  def favorite
    set_recipe
    if current_user.favorites.include?(@recipe)
      current_user.favorites.delete(@recipe)
      render partial: 'components/favoriting/unfavorite', locals: { recipe: @recipe }
    else
      current_user.favorites << @recipe
      render partial: 'components/favoriting/favorite', locals: { recipe: @recipe }
    end
  end

  # GET /recipes or /recipes.json
  def index
    @home = true
    @page = params[:page] || 1
    
    @recipes = Recipe.alphabetical.page(@page)
    @recipe_count = @recipes.total_count

    if params[:search]
      @recipes = Recipe.search_recipes(
                          params[:search],
                          current_user
                        )
                        .alphabetical
                        .with_attached_image
                        .all
                        .page(@page)
      @recipe_count = @recipes.total_count

        respond_to do |format|
          format.html { render partial: 'components/recipe_cards/recipe_cards_container', formats: [:html] }
          format.turbo_stream
        end
    end
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @recipe.steps.build
    @recipe.portions.build
  end

  # GET /recipes/1/edit
  def edit
    @edit = true
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    respond_to do |format|
      begin 
        @recipe.save!
        @recipe.users << current_user
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
      @recipe = Recipe.find_by_slug!(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      # need to explicitly include :id for :steps/:portions for :_destroy to work
      params.require(:recipe).permit(
        :name, 
        :description, 
        :image, 
        category_ids: [], 
        tool_ids: [],                           
        steps_attributes: [
          :id,
          :ingredient_id,
          :name,
          :description,
          :_destroy
        ],
        portions_attributes: [
          :id,
          :ingredient_id,
          :amount,
          :unit,
          :portionable_type,
          :portionable_id,
          :optional,
          :_destroy
        ]
      )                      
    end
end
