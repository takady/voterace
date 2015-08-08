class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :title
      t.string :candidate_1
      t.string :candidate_2

      t.timestamps null: false
    end
  end
end
