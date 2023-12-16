class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user
  has_many :list_recipes, dependent: :destroy
  has_many :lists, through: :list_recipes

  validates :title, :cook_time, :ingredients, :instructions, presence: true

  def self.search_by_title(query)
    where('title LIKE ?',
          "%#{sanitize_sql_like(query)}%")
  end

  def self.search_by_recipe_type(query)
    joins(:recipe_type).where('name LIKE ?',
                              "%#{Recipe.sanitize_sql_like(query)}%")
  end
end
