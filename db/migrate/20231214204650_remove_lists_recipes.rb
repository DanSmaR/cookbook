class RemoveListsRecipes < ActiveRecord::Migration[7.0]
  def change
    drop_join_table :lists, :recipes
  end
end
