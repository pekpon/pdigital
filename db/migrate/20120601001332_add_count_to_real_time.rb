class AddCountToRealTime < ActiveRecord::Migration
  def change
    add_column :real_times, :count, :integer, :default => 1
  end
end
