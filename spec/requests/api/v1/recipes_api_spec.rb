require 'rails_helper'

feature 'GET /api/v1/recipes', type: :request do
  scenario 'returns the recipes' do
    # Arrange
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type, name: 'Sobremesa')
    create(:recipe, title: 'Manjar', cook_time: 60, user: user, recipe_type:,
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

    # Act
    get "/api/v1/recipes"

    # Assert
    expect(response).to have_http_status 200
    expect(response.content_type).to include 'application/json'

    parsed_body = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_body.size).to eq 3
    parsed_body.each do |recipe|
      expect(recipe.keys).to_not include :created_at
      expect(recipe.keys).to_not include :updated_at
      expect(recipe.keys).to include :title
      expect(recipe.keys).to include :cook_time
      expect(recipe.keys).to include :recipe_type
      expect(recipe.keys).to include :user
    end
    expect(parsed_body[0][:user][:email]).to eq 'user@email.com'
    expect(parsed_body[1][:user][:email]).to eq 'user2@email.com'
    expect(parsed_body[2][:user][:email]).to eq 'user2@email.com'
  end
end