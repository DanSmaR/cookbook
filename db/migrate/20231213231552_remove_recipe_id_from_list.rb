class RemoveRecipeIdFromList < ActiveRecord::Migration[7.0]
  def change
    remove_column :lists, :recipe_id
  end
end
