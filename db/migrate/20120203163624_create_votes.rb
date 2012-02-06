class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :article_comment_id
      t.integer :vote_type
      t.string :ip

      t.timestamps
    end
  end
end
