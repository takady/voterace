class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :nickname
      t.string :image_url
      t.string :description
      t.timestamps null: false
    end

    add_index :users, [:provider, :uid], unique: true
  end
end
