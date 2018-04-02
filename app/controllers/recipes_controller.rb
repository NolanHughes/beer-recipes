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
  end

  def create
    raise params.inspect
  end

end
