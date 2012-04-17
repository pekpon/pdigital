class RemoveImageFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :image_file_name
    remove_column :articles, :image_content_type
    remove_column :articles, :image_file_size
    remove_column :articles, :image_updated_at
    
    #Si existe el dir public/system/avatars  rename public/system/images
    #File.rename( "public/system/avatars", "public/system/images" ) if Dir.exist? "public/system/avatars"
  end

  def down
    add_column :articles, :image_file_name
    add_column :articles, :image_content_type
    add_column :articles, :image_file_size
    add_column :articles, :image_updated_at
  end
end