class CreateRaces < ActiveRecord::Migration[4.2]
  def change
    create_table :races do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :candidate_1
      t.string :candidate_2

      t.timestamps null: false
    end
  end
end
