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

    click_on 'Remover'

    expect(page).to have_content 'Receita removida com sucesso'
    expect(current_path).to eq root_path
    expect(Recipe.any?).to be_falsey
  end

  scenario 'não tem autorização para remover receitas de outros usuários' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    another_user = create(:user, email: 'otheruser@email.com', password: '123456', role: :user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, user: user, recipe_type: recipe_type)

    login_as another_user, scope: :user

    visit recipe_path(recipe)

    expect(page).to_not have_button 'Remover'
  end
end
