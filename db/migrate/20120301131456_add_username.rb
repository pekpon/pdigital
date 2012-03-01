class AddUsername < ActiveRecord::Migration
  def up
    add_column :users, :username, :string
  end

  def down
    drop_column :users, :username
  end
end
