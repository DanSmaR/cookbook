class Api::V1::RecipesController < ActionController::API
  def index
    recipes = Recipe.all

    render json: recipes.as_json(only: [:id, :title, :cook_time],
                                 include: {
                                   recipe_type: { only: [:id, :name] },
                                   user: { only: [:email] }
                                 })
  end
end