class AddChangesToArticleComments < ActiveRecord::Migration
  def up
    add_column :article_comments, :commentable_id, :integer
    add_column :article_comments, :commentable_type, :string
  end
  def down
    remove_column :article_comments, :commentable_id
    remove_column :article_comments, :commentable_type
  end
end
