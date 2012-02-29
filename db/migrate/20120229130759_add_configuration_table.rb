class AddConfigurationTable < ActiveRecord::Migration
  def up
    create_table :configurations do |t|
      t.string :key, :uniq => true, :default => ''
      t.string :values
      t.has_attached_file :image

      t.timestamps
    end
    
    Configuration.create([
      {:key => 'head_image_left', :values => 'http://placehold.it/500x100'},
      {:key => 'head_image_right', :values => 'http://placehold.it/400x64'}
    ])
  end

  def down
    drop_table :configurations
  end
end
