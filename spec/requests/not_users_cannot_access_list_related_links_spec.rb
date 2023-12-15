require 'rails_helper'

feature 'Not users role type list access', type: :request do
  scenario 'visitors cannot access lists' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    create(:recipe, user: user, recipe_type: recipe_type)

    get lists_path

    expect(response).to have_http_status 401
    expect(response.body).to include 'Para continuar, faça login ou registre-se.'
  end
end