class Api::V1::RecipesController < ActionController::API
  def index
    recipes = Recipe.all

    unless params[:title].nil?
      recipes = recipes.search_by_title(params[:title])
    end

    unless params[:recipe_type].nil?
      recipes = recipes.search_by_recipe_type(params[:recipe_type])
    end

    render json: recipes.as_json(only: [:id, :title, :cook_time],
                                 include: {
                                   recipe_type: { only: [:id, :name] },
                                   user: { only: [:email] }
                                 })
  end
end