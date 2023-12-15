require 'rails_helper'

feature 'Non users role type have list access', type: :request do
  scenario 'visitors cannot access lists' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    create(:recipe, user: user, recipe_type: recipe_type)

    get lists_path

    expect(response).to have_http_status 302
  end

  scenario 'admin role users cannot access lists' do
    admin = create(:user, email: 'admin@email.com', password: '123456', role: :admin)

    login_as admin
    get lists_path

    expect(response).to have_http_status 401
  end

  scenario 'visitors cannot add recipe to a list' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type, name: 'Lanche')
    recipe1 = create(:recipe, title: 'Hamburguer', cook_time: 10,
                     recipe_type:,
                     ingredients: 'hamburguer, pão de hamburguer, queijo',
                     instructions: 'Frite o hamburguer, coloque no pão, coma')
    recipe2 = create(:recipe, title: 'HotDog', cook_time: 10,
                     user: user,
                     recipe_type: ,
                     ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
                     instructions: 'Asse a salsicha, coloque no pão, coma')

    user.lists.create!(:name => 'Natal')

    user.lists.first&.recipes << recipe1

    get pick_recipe_lists_path(recipe2)

    expect(response).to have_http_status 302

    post add_recipe_lists_path(recipe2), :params => { :list_id => user.lists.first&.id }

    expect(response).to have_http_status 302
  end

  scenario 'admins cannot add recipe to a list' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    admin = create(:user, email: 'admin@email.com', password: '123456', role: :admin)

    recipe_type = create(:recipe_type, name: 'Lanche')
    recipe1 = create(:recipe, title: 'Hamburguer', cook_time: 10,
                     recipe_type:,
                     ingredients: 'hamburguer, pão de hamburguer, queijo',
                     instructions: 'Frite o hamburguer, coloque no pão, coma')
    recipe2 = create(:recipe, title: 'HotDog', cook_time: 10,
                     user: user,
                     recipe_type: ,
                     ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
                     instructions: 'Asse a salsicha, coloque no pão, coma')

    user.lists.create!(:name => 'Natal')

    user.lists.first&.recipes << recipe1

    login_as admin

    get pick_recipe_lists_path(recipe2)

    expect(response).to have_http_status 401

    post add_recipe_lists_path(recipe2), :params => { :list_id => user.lists.first&.id }

    expect(response).to have_http_status 401
  end
end