require 'rails_helper'

feature 'Usuário remove receita' do
  scenario 'com sucesso' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    create(:recipe_type, name: 'Lanche')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, user: user, recipe_type: recipe_type)

    login_as user, scope: :user
    visit recipe_path(recipe)

    expect(page).to have_button 'Remover'
  end

  scenario 'não tem autorização para remover receitas de outros usuários' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    another_user = create(:user, email: 'otheruser@email.com', password: '123456', role: :user)
    create(:recipe_type, name: 'Lanche')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, user: user, recipe_type: recipe_type)

    login_as another_user, scope: :user

    visit edit_recipe_path(recipe)

    expect(current_path).to eq recipe_path(recipe)
    expect(page).to have_content('Não possui autorização para editar essa receita')
  end
end
