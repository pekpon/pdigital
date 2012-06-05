class AddObjectIdToRealTime < ActiveRecord::Migration
  def change
    add_column :real_times, :article_id, :integer

  end
end
