require 'rails_helper'

feature 'Usuario vê Listas para escolher' do
  scenario 'com sucesso' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe2 = create(:recipe, title: 'Manjar', cook_time: 60,
           recipe_type:,
           ingredients: 'leite condensado, leite, leite de coco',
           instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira')
    recipe_type = create(:recipe_type, name: 'Lanche')
    recipe1 = create(:recipe, title: 'Hamburguer', cook_time: 10,
           recipe_type:,
           ingredients: 'hamburguer, pão de hamburguer, queijo',
           instructions: 'Frite o hamburguer, coloque no pão, coma')

    user.lists.create!(:name => 'Natal')
    user.lists.create!(:name => 'Fit')

    login_as user, scope: :user
    visit recipe_path(recipe1)

    expect(page).to have_link('Adicionar à Lista')
    click_on 'Adicionar à Lista'
    expect(page).to have_content('Adicionar Receita à Lista')
    expect(page).to have_field('Selecione a Lista')
    expect(page).to have_select 'Selecione a Lista', options: %w[Natal Fit]
    expect(page).to have_button('Adicionar')
  end

  scenario 'e adiciona com sucesso' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type, name: 'Sobremesa')
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
                     user: user,
                     recipe_type: ,
                     ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
                     instructions: 'Asse a salsicha, coloque no pão, coma')

    user.lists.create!(:name => 'Natal')
    user.lists.create!(:name => 'Fit')

    user.lists.first&.recipes << recipe1

    login_as user, scope: :user
    visit recipe_path(recipe3)

    click_on 'Adicionar à Lista'
    select 'Natal', from: 'Selecione a Lista'
    click_on 'Adicionar'

    expect(page).to have_content('Adicionada receita com sucesso')
    expect(current_path).to eq recipe_path(recipe3)
    expect(List.first.recipes.count).to eq 2
  end
end