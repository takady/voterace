class AddColumnCandidateIdToVotes < ActiveRecord::Migration
  def up
    rename_column :votes, :candidate, :candidate_order
    add_column :votes, :candidate_id, :integer, null: false
  end

  def down
    remove_column :votes, :candidate_id
    rename_column :votes, :candidate_order, :candidate
  end
end
