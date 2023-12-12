require 'rails_helper'

feature 'Usuário tenta remover receita de outro usuário', type: :request do
  scenario 'Sem sucesso' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    another_user = create(:user, email: 'otheruser@email.com', password: '123456', role: :user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, user: user, recipe_type: recipe_type)

    login_as another_user, scope: :user

    delete recipe_path(recipe)

    expect(response).to have_http_status :unprocessable_entity
    expect(response.body).to include 'Não possui autorização para remover essa receita'
  end
end