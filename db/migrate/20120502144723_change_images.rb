class ChangeImages < ActiveRecord::Migration
  def up
    change_column :images, :aux, :boolean, :default => false
  end

  def down
    change_column :images, :aux, :boolean, :default => nil
  end
end
