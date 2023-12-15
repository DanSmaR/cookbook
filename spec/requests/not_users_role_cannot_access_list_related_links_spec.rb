require 'rails_helper'

feature 'Non users role type have list access', type: :request do
  scenario 'visitors cannot access lists' do
    user = create(:user, email: 'user@email.com', password: '123456', role: :user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    create(:recipe, user: user, recipe_type: recipe_type)

    get lists_path

    expect(response).to have_http_status 302
  end
end