class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    unless @recipe.user == current_user
      flash[:alert] = t('.error')
      redirect_to recipe_path(@recipe)
    end
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      flash[:notice] = t('.success')
      return redirect_to(@recipe)
    end
    flash.now[:alert] = t('.error')
    render :new
  end

  def update
    @recipe = Recipe.find(params[:id])

    return redirect_to @recipe if @recipe.update(recipe_params)

    render :edit
  end

  def destroy
    recipe = current_user.recipes.find(params[:id])

    if recipe.nil?
      flash.now[:alert] = t('.error')
      return render :show
    end

    recipe.destroy
    flash[:notice] = t('.success')
    redirect_to root_path, status: :see_other
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id,
                                   :cook_time, :ingredients,
                                   :instructions)
  end
end
