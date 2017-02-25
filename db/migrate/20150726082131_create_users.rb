class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email
      t.string :fullname
      t.string :image_url
      t.string :description

      t.timestamps null: false
    end

    add_index :users, :username, unique: true
    add_index :users, :email
  end
end
