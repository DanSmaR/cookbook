class Api::V1::RecipesController < ActionController::API
  def index
    recipes = Recipe.all

    unless params[:title].nil?
      recipes = recipes.where('title LIKE ?',
                              "%#{Recipe.sanitize_sql_like(params[:title])}%")
    end

    render json: recipes.as_json(only: [:id, :title, :cook_time],
                                 include: {
                                   recipe_type: { only: [:id, :name] },
                                   user: { only: [:email] }
                                 })
  end
end