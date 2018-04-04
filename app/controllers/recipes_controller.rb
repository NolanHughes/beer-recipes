class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all

    unless user_signed_in?
      flash[:alert] = "Please log in to create or edit a recipe."
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new

    @hops = Hop.all
    @yeasts = Yeast.all
    @fermentables = Fermentable.all

    @recipe.fermentables.build
    @recipe.hops.build
    @recipe.yeasts.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      redirect_to new_recipe_path #This won't render errors
    end

  end

  def edit
    @recipe = Recipe.find(params[:id])

    @hops = Hop.all
    @yeasts = Yeast.all
    @fermentables = Fermentable.all

    @recipe.fermentables.build
    @recipe.hops.build
    @recipe.yeasts.build
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)

    redirect_to recipe_path(@recipe)
  end

  private

    def recipe_params
      params.require(:recipe).permit(:name,
                                     :boil_time,
                                     :fermentable_ids => [],
                                     :fermentables_attributes => [:name],
                                     :hop_ids => [],
                                     :hops_attributes => [:name],
                                     :yeast_ids => [],
                                     :yeasts_attributes => [:brand, :variety]
                                   )
    end

end
