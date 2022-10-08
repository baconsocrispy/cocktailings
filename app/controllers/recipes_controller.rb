class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @recipe.steps.build
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    # need to except ingredients or there will be an error
    @recipe = Recipe.new(recipe_params.except(:portions))

    respond_to do |format|
      # Need to add this to prevent form from submitting
      # when adding a step.
      
      # process_portions method explained in application_controller.rb
      if @recipe.save && process_portions(@recipe, params) && process_steps(@recipe, params)
        format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      # process_portions method explained in application_controller.rb
      if @recipe.update(recipe_params) && process_portions(@recipe, params) && process_steps(@recipe, params)
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
      params.require(:recipe).permit(:name, 
                                     :description, 
                                     :image, 
                                     steps_attributes: [
                                      :id, 
                                      :number, 
                                      :name, 
                                      :description, 
                                      :_destroy]
                                    )
    end
end
