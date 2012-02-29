class AddConfigurationTable < ActiveRecord::Migration
  def up
    create_table :configurations do |t|
      t.string :key, :uniq => true, :default => ''
      t.string :values
      t.has_attached_file :image

      t.timestamps
    end
  end

  def down
    drop_table :configurations
  end
end
