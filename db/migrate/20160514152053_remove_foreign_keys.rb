class RemoveForeignKeys < ActiveRecord::Migration[4.2]
  def change
    remove_foreign_key :candidates, :races
    remove_foreign_key :races, :users
    remove_foreign_key :social_profiles, :users
    remove_foreign_key :votes, :races
    remove_foreign_key :votes, :users
  end
end
