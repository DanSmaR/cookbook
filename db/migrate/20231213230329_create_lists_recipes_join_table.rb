class CreateListsRecipesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :lists, :recipes do |t|
      t.index :list_id
      t.index :recipe_id
    end
  end
end
