class AddColumnCandidateIdToVotes < ActiveRecord::Migration
  def up
    rename_column :votes, :candidate, :candidate_order
    add_column :votes, :candidate_id, :integer, null: false

    Vote.all.each do |vote|
      vote.update!(candidate_id: Candidate.find_by(race_id: vote.race_id, order: vote.candidate_order).id)
    end
  end

  def down
    remove_column :votes, :candidate_id
    rename_column :votes, :candidate_order, :candidate
  end
end
