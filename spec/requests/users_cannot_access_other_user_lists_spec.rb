require 'rails_helper'

feature 'Users cannot access other user lists', type: :request do
  scenario 'by requesting access via url' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    another_user = create(:user, email: 'another@email.com', password: '123456', role: :user)

    recipe_type = create(:recipe_type, name: 'Lanche')
    recipe1 = create(:recipe, title: 'Hamburguer', cook_time: 10,
                     recipe_type:,
                     ingredients: 'hamburguer, pão de hamburguer, queijo',
                     instructions: 'Frite o hamburguer, coloque no pão, coma')

    list = user.lists.create!(:name => 'Natal')

    list.recipes << recipe1

    login_as another_user

    get list_path(list)

    expect(response).to have_http_status 401
  end
end