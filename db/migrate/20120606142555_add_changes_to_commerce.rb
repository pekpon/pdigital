class AddChangesToCommerce < ActiveRecord::Migration
  def up
    add_column :commerces, :user_id, :integer
    add_column :commerces, :web, :string
    change_column :commerces, :time, :text
    rename_column :commerces, :time, :schedule
  end
  
  def down
    remove_column :commerces, :user_id
    remove_column :commerces, :web
    change_column :commerces, :schedule, :string
    rename_column :commerces, :schedule, :time
  end
end
