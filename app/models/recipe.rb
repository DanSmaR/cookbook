class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user
  has_and_belongs_to_many :lists

  validates :title, :cook_time, :ingredients, :instructions, presence: true
end
