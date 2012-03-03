class AddOldUserToArticleComment < ActiveRecord::Migration
  def up
    add_column :article_comments, :username, :string
  end

  def down
    drop_column :article_comments, :username
  end
end
