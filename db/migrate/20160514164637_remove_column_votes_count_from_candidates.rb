class RemoveColumnVotesCountFromCandidates < ActiveRecord::Migration[4.2]
  def change
    remove_column :candidates, :votes_count
  end
end
