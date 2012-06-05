class RenameColumnsRealTime < ActiveRecord::Migration
  def up
    rename_column :real_times, :article_id, :object_id
  end

  def down
    rename_column :real_times, :object_id, :article_id
  end
end
