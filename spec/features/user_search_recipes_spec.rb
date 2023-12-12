require 'rails_helper'

feature 'Busca de receitas' do
  scenario 'accessível pelo cabeçalho da página' do
    visit root_path

    within 'header' do
      expect(page).to have_field 'Busca Receitas'
      expect(page).to have_button 'Buscar'
    end
  end

  scenario 'busca pelo nome com sucesso' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    recipe_type1 = create(:recipe_type, name: 'Sobremesa')
    recipe_type2 = create(:recipe_type, name: 'Lanche')
    recipe1 = create(:recipe, user: user, recipe_type: recipe_type1)
    recipe2 = create(:recipe, title: "Hamburguer", user: user, recipe_type: recipe_type2)
    recipe3 = create(:recipe, title: "Manjar", user: user, recipe_type: recipe_type1)

    visit root_path
    fill_in 'Busca Receitas', with: 'Manjar'
    click_on 'Buscar'

    expect(current_path).to eq search_recipes_path
    expect(page).to have_content '1 receita encontrada'
    expect(page).to have_content('Manjar')
    expect(page).to have_content('Sobremesa')
    expect(page).to have_content('30 minutos')
  end

  scenario 'sem termo de busca, mostra erro' do
    visit root_path
    fill_in 'Busca Receitas', with: ''
    click_on 'Buscar'

    expect(page).to have_content 'Termo para pesquisa está vazio'
    expect(current_path).to eq root_path
  end
end