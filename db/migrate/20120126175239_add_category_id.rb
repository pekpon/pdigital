class AddCategoryId < ActiveRecord::Migration
  def up
    change_table :articles do |t|
      t.integer :category_id
    end

  end

  def down
	remove_column :articles, :category_id  
  end
end
