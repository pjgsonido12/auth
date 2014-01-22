class AddReassignedCountToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :reassigned_count, :integer
  end
  
  def self.down
     remove_column :tasks, :reassigned_count, :integer
  end
end
