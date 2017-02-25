class AddExiredAtToRace < ActiveRecord::Migration[4.2]
  def change
    add_column :races, :expired_at, :timestamp, null: false
  end
end
