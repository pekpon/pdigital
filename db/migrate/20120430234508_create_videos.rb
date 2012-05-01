class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.integer :article_id
      t.string :youtube_code
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end

  def down
      drop_table :videos
  end
end