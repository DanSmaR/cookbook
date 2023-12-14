require 'rails_helper'

feature 'Usuario remove receitas da lista' do
  scenario 'com sucesso' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type)
    recipe2 = create(:recipe, title: 'Manjar', cook_time: 60,
                     recipe_type:,
                     ingredients: 'leite condensado, leite, leite de coco',
                     instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira')
    recipe_type = create(:recipe_type, name: 'Lanche')
    recipe1 = create(:recipe, title: 'Hamburguer', cook_time: 10,
                     recipe_type:,
                     ingredients: 'hamburguer, pão de hamburguer, queijo',
                     instructions: 'Frite o hamburguer, coloque no pão, coma')
    recipe3 = create(:recipe, title: 'HotDog', cook_time: 10,
                     recipe_type: ,
                     ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
                     instructions: 'Asse a salsicha, coloque no pão, coma')

    user.lists.create!(:name => 'Natal')
    user.lists.create!(:name => 'Fit')

    user.lists.first&.recipes << recipe1
    user.lists.first&.recipes << recipe2
    user.lists.first&.recipes << recipe3

    login_as user, scope: :user
    visit list_path(user.lists.first)

    expect(page).to have_button 'Remover', count: 3
  end
end