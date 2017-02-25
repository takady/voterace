class RemoveColumnCandidateOrderFromVotes < ActiveRecord::Migration[4.2]
  def change
    remove_column :votes, :candidate_order
  end
end
