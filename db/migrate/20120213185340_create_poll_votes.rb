class CreatePollVotes < ActiveRecord::Migration
  def change
    create_table :poll_votes do |t|
      t.integer :poll_id
      t.integer :poll_option_id
      t.string :ip

      t.timestamps
    end
  end
end
