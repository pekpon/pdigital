class AddActiveToDebates < ActiveRecord::Migration
  def up
    add_column :debates, :active, :boolean, :default => true

  end
  
  def down
    remove_column :debates, :active
  end
end
