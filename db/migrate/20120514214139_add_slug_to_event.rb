class AddSlugToEvent < ActiveRecord::Migration
  def up
     add_column :events, :slug, :string
   end

   def down
     remove_column :events, :slug
   end
end