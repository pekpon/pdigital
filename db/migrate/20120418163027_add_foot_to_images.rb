class AddFootToImages < ActiveRecord::Migration
  def up
    add_column :images, :image_foot, :string
  end
  def down
    remove_column :images, :image_foot
  end 
end
