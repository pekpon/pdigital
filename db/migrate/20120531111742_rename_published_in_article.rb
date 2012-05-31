class RenamePublishedInArticle < ActiveRecord::Migration
  def up
    rename_column :articles, :published, :active
  end

  def down
    rename_column :articles, :active, :published
  end
end
