class AddAuxToImages < ActiveRecord::Migration
  def up
    add_column :images, :aux, :boolean

  end
  def down
    remove_column :images, :aux
  end
end
