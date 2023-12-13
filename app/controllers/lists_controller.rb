class ListsController < ApplicationController
  def lists
    @recipe = Recipe.find(params[:recipe_id])
    @lists = current_user.lists.all
  end

  def add_recipe
    @recipe = Recipe.find(params[:recipe_id])
    @list = List.find(params[:list_id])
    @list.recipes
  end
end