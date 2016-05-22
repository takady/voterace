class RemoveColumnCandidateOrderFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :candidate_order
  end
end
