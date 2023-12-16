require 'rails_helper'

feature 'GET /api/v1/recipes', type: :request do
  scenario 'returns the recipes' do
    # Arrange
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe1 = create(:recipe, title: 'Manjar', cook_time: 60, user: user, recipe_type:,
           ingredients: 'leite condensado, leite, leite de coco',
           instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira')

    recipe_type = create(:recipe_type, name: 'Lanche')
    user2 = create(:user, email: 'user2@email.com', password: '123456', role: :user)
    recipe2 = create(:recipe, title: 'Hamburguer', cook_time: 10, user: user2, recipe_type:,
           ingredients: 'hamburguer, pão de hamburguer, queijo',
           instructions: 'Frite o hamburguer, coloque no pão, coma')
    recipe3 = create(:recipe, title: 'HotDog', cook_time: 10, user: user2, recipe_type: ,
           ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
           instructions: 'Asse a salsicha, coloque no pão, coma')

    recipes = [recipe1, recipe2, recipe3]

    # Act
    get "/api/v1/recipes"

    # Assert
    expect(response).to have_http_status 200
    expect(response.content_type).to include 'application/json'

    parsed_body = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_body.size).to eq 3
    parsed_body.each_with_index do |recipe, index|
      expect(recipe.keys).to_not include :created_at
      expect(recipe.keys).to_not include :updated_at
      expect(recipe.keys).to include :title
      expect(recipe[:title]).to eq recipes[index][:title]
      expect(recipe.keys).to include :cook_time
      expect(recipe[:cook_time]).to eq recipes[index][:cook_time]
      expect(recipe.keys).to include :recipe_type
      expect(recipe[:recipe_type].keys).to include :name
      expect(recipe[:recipe_type][:name]).to eq recipes[index].recipe_type.name
      expect(recipe[:recipe_type].keys).to_not include :created_at
      expect(recipe[:recipe_type].keys).to_not include :updated_at
      expect(recipe.keys).to include :user
      expect(recipe[:user].keys).to include :email
      expect(recipe[:user][:email]).to eq recipes[index].user.email
      expect(recipe[:user].keys).to_not include :created_at
      expect(recipe[:user].keys).to_not include :updated_at
      expect(recipe[:user].keys).to_not include :role
      expect(recipe.keys).to_not include :instructions
      expect(recipe.keys).to_not include :ingredients
    end
  end

  scenario 'searching recipes by title, returns the related ones' do
    # Arrange
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe1 = create(:recipe, title: 'Manjar', cook_time: 60, user: user, recipe_type:,
                     ingredients: 'leite condensado, leite, leite de coco',
                     instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira')

    recipe_type = create(:recipe_type, name: 'Lanche')
    user2 = create(:user, email: 'user2@email.com', password: '123456', role: :user)
    recipe2 = create(:recipe, title: 'Hamburguer', cook_time: 10, user: user2, recipe_type:,
                     ingredients: 'hamburguer, pão de hamburguer, queijo',
                     instructions: 'Frite o hamburguer, coloque no pão, coma')
    recipe3 = create(:recipe, title: 'HotDog', cook_time: 10, user: user2, recipe_type: ,
                     ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
                     instructions: 'Asse a salsicha, coloque no pão, coma')

    recipes = [recipe1, recipe2]

    # Act
    query = { title: 'a' }
    get "/api/v1/recipes?#{query.to_query}"

    # Assert
    expect(response).to have_http_status 200
    expect(response.content_type).to include 'application/json'

    parsed_body = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_body.size).to eq recipes.count
    parsed_body.each_with_index do |recipe, index|
      expect(recipe.keys).to_not include :created_at
      expect(recipe.keys).to_not include :updated_at
      expect(recipe.keys).to include :title
      expect(recipe[:title]).to eq recipes[index][:title]
      expect(recipe.keys).to include :cook_time
      expect(recipe[:cook_time]).to eq recipes[index][:cook_time]
      expect(recipe.keys).to include :recipe_type
      expect(recipe[:recipe_type].keys).to include :name
      expect(recipe[:recipe_type][:name]).to eq recipes[index].recipe_type.name
      expect(recipe[:recipe_type].keys).to_not include :created_at
      expect(recipe[:recipe_type].keys).to_not include :updated_at
      expect(recipe.keys).to include :user
      expect(recipe[:user].keys).to include :email
      expect(recipe[:user][:email]).to eq recipes[index].user.email
      expect(recipe[:user].keys).to_not include :created_at
      expect(recipe[:user].keys).to_not include :updated_at
      expect(recipe[:user].keys).to_not include :role
      expect(recipe.keys).to_not include :instructions
      expect(recipe.keys).to_not include :ingredients
    end
  end

  scenario 'searching recipes by recipe type, returns the related ones' do
    # Arrange
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe1 = create(:recipe, title: 'Manjar', cook_time: 60, user: user, recipe_type:,
                     ingredients: 'leite condensado, leite, leite de coco',
                     instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira')

    recipe_type = create(:recipe_type, name: 'Lanche')
    user2 = create(:user, email: 'user2@email.com', password: '123456', role: :user)
    create(:recipe, title: 'Hamburguer', cook_time: 10, user: user2, recipe_type:,
                     ingredients: 'hamburguer, pão de hamburguer, queijo',
                     instructions: 'Frite o hamburguer, coloque no pão, coma')
    create(:recipe, title: 'HotDog', cook_time: 10, user: user2, recipe_type: ,
                     ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
                     instructions: 'Asse a salsicha, coloque no pão, coma')

    recipes = [recipe1]

    # Act
    query = { recipe_type: 'sob' }
    get "/api/v1/recipes?#{query.to_query}"

    # Assert
    expect(response).to have_http_status 200
    expect(response.content_type).to include 'application/json'

    parsed_body = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_body.size).to eq recipes.count
    parsed_body.each_with_index do |recipe, index|
      expect(recipe.keys).to_not include :created_at
      expect(recipe.keys).to_not include :updated_at
      expect(recipe.keys).to include :title
      expect(recipe[:title]).to eq recipes[index][:title]
      expect(recipe.keys).to include :cook_time
      expect(recipe[:cook_time]).to eq recipes[index][:cook_time]
      expect(recipe.keys).to include :recipe_type
      expect(recipe[:recipe_type].keys).to include :name
      expect(recipe[:recipe_type][:name]).to eq recipes[index].recipe_type.name
      expect(recipe[:recipe_type].keys).to_not include :created_at
      expect(recipe[:recipe_type].keys).to_not include :updated_at
      expect(recipe.keys).to include :user
      expect(recipe[:user].keys).to include :email
      expect(recipe[:user][:email]).to eq recipes[index].user.email
      expect(recipe[:user].keys).to_not include :created_at
      expect(recipe[:user].keys).to_not include :updated_at
      expect(recipe[:user].keys).to_not include :role
      expect(recipe.keys).to_not include :instructions
      expect(recipe.keys).to_not include :ingredients
    end
  end

  scenario 'searching recipes by title and recipe type, returns the related ones' do
    # Arrange
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe1 = create(:recipe, title: 'Manjar', cook_time: 60, user: user, recipe_type:,
                     ingredients: 'leite condensado, leite, leite de coco',
                     instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira')

    recipe_type = create(:recipe_type, name: 'Lanche')
    user2 = create(:user, email: 'user2@email.com', password: '123456', role: :user)
    create(:recipe, title: 'Hamburguer', cook_time: 10, user: user2, recipe_type:,
           ingredients: 'hamburguer, pão de hamburguer, queijo',
           instructions: 'Frite o hamburguer, coloque no pão, coma')
    create(:recipe, title: 'HotDog', cook_time: 10, user: user2, recipe_type: ,
           ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
           instructions: 'Asse a salsicha, coloque no pão, coma')

    recipes = [recipe1]

    # Act
    query = { title: 'a', recipe_type: 'sob' }
    get "/api/v1/recipes?#{query.to_query}"

    # Assert
    expect(response).to have_http_status 200
    expect(response.content_type).to include 'application/json'

    parsed_body = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_body.size).to eq recipes.count
    parsed_body.each_with_index do |recipe, index|
      expect(recipe.keys).to_not include :created_at
      expect(recipe.keys).to_not include :updated_at
      expect(recipe.keys).to include :title
      expect(recipe[:title]).to eq recipes[index][:title]
      expect(recipe.keys).to include :cook_time
      expect(recipe[:cook_time]).to eq recipes[index][:cook_time]
      expect(recipe.keys).to include :recipe_type
      expect(recipe[:recipe_type].keys).to include :name
      expect(recipe[:recipe_type][:name]).to eq recipes[index].recipe_type.name
      expect(recipe[:recipe_type].keys).to_not include :created_at
      expect(recipe[:recipe_type].keys).to_not include :updated_at
      expect(recipe.keys).to include :user
      expect(recipe[:user].keys).to include :email
      expect(recipe[:user][:email]).to eq recipes[index].user.email
      expect(recipe[:user].keys).to_not include :created_at
      expect(recipe[:user].keys).to_not include :updated_at
      expect(recipe[:user].keys).to_not include :role
      expect(recipe.keys).to_not include :instructions
      expect(recipe.keys).to_not include :ingredients
    end
  end
end