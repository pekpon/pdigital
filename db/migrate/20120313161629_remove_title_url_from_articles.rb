class RemoveTitleUrlFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :title_url
  end

  def down
    add_column :articles, :title_url, :string
  end
end
