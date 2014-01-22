class AddReopenCountToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :reopen_count, :integer
  end
  
  def self.down
     remove_column :tasks, :reopen_count, :integer
  end
end
