class AddResumeToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :article_resume, :string
  end
  def down
    remove_column :articles, :article_resume
  end
end
