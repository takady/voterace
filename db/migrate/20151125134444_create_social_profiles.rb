class CreateSocialProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :username

      t.timestamps null: false
    end

    add_index :social_profiles, [:provider, :uid], unique: true
  end
end
