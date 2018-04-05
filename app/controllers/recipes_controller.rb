class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
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
      render 'recipes/new'
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
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render 'recipes/edit'
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.recipe_fermentables.destroy_all
    recipe.recipe_hops.destroy_all
    recipe.recipe_yeasts.destroy_all
    recipe.destroy

    redirect_to user_path
  end

  private

    def recipe_params
      params.require(:recipe).permit(:name,
                                     :boil_time,
                                     :fermentable_ids => [],
                                     :fermentables_attributes => [:name, :pound_per_gallon, :lovibond, :diastatic_power],
                                     :hop_ids => [],
                                     :hops_attributes => [:name, :alpha_acids],
                                     :yeast_ids => [],
                                     :yeasts_attributes => [:brand, :variety]
                                   )
    end

end
