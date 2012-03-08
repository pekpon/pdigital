class RenameAvatarColumn < ActiveRecord::Migration
  def up
    rename_column :articles, :avatar_file_name, :image_file_name
    rename_column :articles, :avatar_content_type, :image_content_type
    rename_column :articles, :avatar_file_size, :image_file_size
    rename_column :articles, :avatar_updated_at, :image_updated_at
    
    #Si existe el dir public/system/avatars  rename public/system/images
    File.rename( "public/system/avatars", "public/system/images" ) if Dir.exist? "public/system/avatars"
  end

  def down
    rename_column :articles, :image_file_name, :avatar_file_name
    rename_column :articles, :image_content_type, :avatar_content_type
    rename_column :articles, :image_file_size, :avatar_file_size
    rename_column :articles, :image_updated_at, :avatar_updated_at
    #Si existe el dir public/system/images rename public/system/avatar
    File.rename( "public/system/images", "public/system/avatars" ) if Dir.exist? "public/system/images"
    
  end
end
