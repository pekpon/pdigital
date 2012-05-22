class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :body
      t.integer :commentable_id
      t.string :commentable_type
      t.boolean :active
      t.string :username
      
      t.timestamps
    end
  end
end
