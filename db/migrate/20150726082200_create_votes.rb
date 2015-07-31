class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :candidate

      t.timestamps null: false
    end
  end
end
