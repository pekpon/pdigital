class CreateDebates < ActiveRecord::Migration
  def change
    create_table :debates do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
  end
end
