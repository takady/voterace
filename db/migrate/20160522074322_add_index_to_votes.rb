class AddIndexToVotes < ActiveRecord::Migration[4.2]
  def change
    add_index :votes, :candidate_id
  end
end
