class AddIndexToVotes < ActiveRecord::Migration
  def change
    add_index :votes, :candidate_id
  end
end
