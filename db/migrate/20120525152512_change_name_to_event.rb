class ChangeNameToEvent < ActiveRecord::Migration
  def up
    rename_column :events, :name, :title
  end

  def down
    rename_column :events, :title, :name
  end
end
