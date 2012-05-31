class AddColumnsToRealTime < ActiveRecord::Migration
  def up
    add_column :real_times, :subtype, :string
    add_column :real_times, :user_id, :integer

  end
  
  def down
    remove_column :real_times, :subtype
    remove_column :real_times, :user_id
    
  end
end
