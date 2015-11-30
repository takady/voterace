class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :race, index: true, foreign_key: true
      t.integer :candidate

      t.timestamps null: false
    end
  end
end
