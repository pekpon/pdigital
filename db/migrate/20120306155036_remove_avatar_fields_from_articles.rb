class RemoveAvatarFieldsFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :avatar_file_name
        remove_column :articles, :avatar_content_type
        remove_column :articles, :avatar_file_size
        remove_column :articles, :avatar_updated_at
      end

  def down
    add_column :articles, :avatar_updated_at, :datetime
    add_column :articles, :avatar_file_size, :string
    add_column :articles, :avatar_content_type, :string
    add_column :articles, :avatar_file_name, :string
  end
end
