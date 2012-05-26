class AddLocationToEvents < ActiveRecord::Migration
  def up
    add_column :events, :location, :string, :default => ""

  end
  
  def down
    remove_column :events, :location
    
  end
end
