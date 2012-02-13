class CreatePollOptions < ActiveRecord::Migration
  def change
    create_table :poll_options do |t|
      t.string :option
      t.integer :poll_id

      t.timestamps
    end
  end
end
