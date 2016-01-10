class AddExiredAtToRace < ActiveRecord::Migration
  def change
    add_column :races, :expired_at, :timestamp, null: false
  end
end
