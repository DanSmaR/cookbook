class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user
  has_many :list_recipes
  has_many :lists, through: :list_recipes

  validates :title, :cook_time, :ingredients, :instructions, presence: true

  def self.search(query)
    where('title LIKE ?',
          "%#{sanitize_sql_like(query)}%")
  end
end
