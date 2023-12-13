class ListsController < ApplicationController
  def pick
    @recipe = Recipe.find(params[:recipe_id])
    @lists = current_user.lists.all
  end

  def add
    @recipe = Recipe.find(params[:recipe_id])
    @list = List.find(params[:list_id])
    @list.recipes << @recipe

    redirect_to recipe_path(@recipe), notice: 'Adicionada receita com sucesso'
  end
end