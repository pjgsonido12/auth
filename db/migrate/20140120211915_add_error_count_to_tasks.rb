class AddErrorCountToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :error_count, :integer
  end
  
  def self.down
     remove_column :tasks, :error_count, :integer
  end
end
