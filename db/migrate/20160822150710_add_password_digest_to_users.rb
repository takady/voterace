class AddPasswordDigestToUsers < ActiveRecord::Migration[4.2][5.0]
  def change
    add_column :users, :password_digest, :string
  end
end
