require 'rails_helper'

feature 'Usuario adiciona receita em lista' do
  scenario 'com sucesso' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    create(:recipe, title: 'Manjar', cook_time: 60,
           recipe_type:,
           ingredients: 'leite condensado, leite, leite de coco',
           instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira')
    recipe_type = create(:recipe_type, name: 'Lanche')
    recipe1 = create(:recipe, title: 'Hamburguer', cook_time: 10,
           recipe_type:,
           ingredients: 'hamburguer, pão de hamburguer, queijo',
           instructions: 'Frite o hamburguer, coloque no pão, coma')

    login_as user, scope: :user
    visit recipe_path(recipe1)

    expect(page).to have_link('Adicionar à Lista')
    expect(page).to have_content('Lista de Receitas')
  end
end