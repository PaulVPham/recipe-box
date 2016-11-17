class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :edit, :destroy]

  def index
    @recipe = Recipe.all.order("created_at DESC")
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Successfully created new recipe"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @recipe = Recipe.find(params[:id])
    # recipe id wasn't defined previously in the update method
    if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: "Successfully deleted recipe"
  end

  private
  def recipe_params
    params.require(:recipe).permit(:id, :title, :description, :image, ingredients_attributes:
    [:id, :name, :destroy], directions_attributes: [:id, :name, :step, :_destroy])
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

end
