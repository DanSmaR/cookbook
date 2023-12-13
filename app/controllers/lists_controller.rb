class ListsController < ApplicationController
  def lists
    @recipe = Recipe.find(params[:recipe_id])
    @lists = current_user.lists.all
  end

  def add_recipe
    @recipe = Recipe.find(params)
  end
end