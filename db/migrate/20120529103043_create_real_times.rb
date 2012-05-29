class CreateRealTimes < ActiveRecord::Migration
  def change
    create_table :real_times do |t|
      t.integer :trackeable_id
      t.string :trackeable_type

      t.timestamps
    end
  end
end
