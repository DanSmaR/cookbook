require 'rails_helper'

feature 'Usuário remove lista de receitas' do
  scenario 'com sucesso' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type, name: 'Lanche')
    recipe1 = create(:recipe, title: 'Hamburguer', cook_time: 10,
                     recipe_type:,
                     ingredients: 'hamburguer, pão de hamburguer, queijo',
                     instructions: 'Frite o hamburguer, coloque no pão, coma')

    user.lists.create!(:name => 'Natal')
    user.lists.create!(:name => 'Fit')

    user.lists.first&.recipes << recipe1

    login_as user, scope: :user
    visit lists_path

    expect(page).to have_button 'Remover'

    click_button 'Remover'

    expect(page).to have_content 'Lista removida com sucesso'
    expect(page).to have_current_path(lists_path)
    expect(page).to_not have_content('Natal')
    expect(page).to have_content('Fit')
    expect(user.lists.count).to eq 1
  end
end