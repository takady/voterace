class CreateCandidates < ActiveRecord::Migration[4.2]
  def change
    create_table :candidates do |t|
      t.references :race, index: true, foreign_key: true
      t.string :name, null: false
      t.integer :order, nill: false
      t.integer :votes_count, default: 0

      t.timestamps null: false
    end
  end
end
