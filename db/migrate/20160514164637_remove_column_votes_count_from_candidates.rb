class RemoveColumnVotesCountFromCandidates < ActiveRecord::Migration
  def change
    remove_column :candidates, :votes_count
  end
end
