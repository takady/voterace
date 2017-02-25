class ChangeColumnTypeDescriptionOfUsers < ActiveRecord::Migration[4.2]
  def up
    change_column :users, :description, :text
  end

  def down
    change_column :users, :description, :string
  end
end
