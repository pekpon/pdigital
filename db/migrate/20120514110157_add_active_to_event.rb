class AddActiveToEvent < ActiveRecord::Migration
  def up
    add_column :events, :active, :boolean, :default => false
  end
  
  def down
    remove_column :events, :active
  end
end