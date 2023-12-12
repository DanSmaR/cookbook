require 'rails_helper'

feature 'Busca de receitas' do
  scenario 'accessível pelo cabeçalho da página' do
    visit root_path

    expect(page).to have_field 'Buscar receitas'
  end
end