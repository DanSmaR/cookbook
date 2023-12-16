require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe '.search' do
    it 'retorna uma instância de acordo com o valor da procura' do
      user = create(:user, email: 'user@email.com', password: '123456', role: :user)
      recipe_type1 = create(:recipe_type, name: 'Sobremesa')
      recipe_type2 = create(:recipe_type, name: 'Lanche')
      create(:recipe, user: user, recipe_type: recipe_type1)
      create(:recipe, title: "Hamburguer", user: user, recipe_type: recipe_type2)
      create(:recipe, title: "Manjar", user: user, recipe_type: recipe_type1)

      result = Recipe.search_by_title('m')

      expect(result.all.count).to eq 2
      expect(result.first.title).to eq 'Hamburguer'
      expect(result.last.title).to eq 'Manjar'
    end
  end
end