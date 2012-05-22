class AddCommentToVote < ActiveRecord::Migration
  def up
    add_column :votes, :comment_id, :integer
    #remove_column :votes, :article_comment_id
  end
  
  def down
    remove_column :votes, :comment_id
    #add_column :votes, :article_comment_id, :integer
  end
end
