class ListRecipe < ApplicationRecord
  belongs_to :list
  belongs_to :recipe

  validates :recipe_id, uniqueness: { scope: :list_id }
end
