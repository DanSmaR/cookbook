class ListsController < ApplicationController
  def pick
    @recipe = Recipe.find(params[:recipe_id])
    @lists = current_user.lists.all
    @list = current_user.lists.new
  end

  def add
    @recipe = Recipe.find(params[:recipe_id])
    @list = List.find(params[:list_id])
    @list.recipes << @recipe

    redirect_to recipe_path(@recipe), notice: t('.success')
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @list = current_user.lists.build(list_params)

    if @list.save
      flash[:notice] = t('.success')
      return redirect_to pick_recipe_lists_path(@recipe)
    end
    flash[:alert] = "#{t('.error')} #{ @list.errors.full_messages_for(:name).join(', ')}"
    redirect_to pick_recipe_lists_path(@recipe)
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end