class CreateArticleComments < ActiveRecord::Migration
  def change
    create_table :article_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :article_id
      t.boolean :active

      t.timestamps
    end
  end
end
