class ListsController < ApplicationController
  def lists
    @recipe = params[:recipe_id]
    @lists = current_user.lists.all
  end
end