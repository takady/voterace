class RemoveColumnCandidateFromRaces < ActiveRecord::Migration[4.2]
  def change
    remove_column :races, :candidate_1
    remove_column :races, :candidate_2
  end
end
