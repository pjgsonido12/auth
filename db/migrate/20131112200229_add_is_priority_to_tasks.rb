class AddIsPriorityToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :is_priority, :boolean
  end
  
  def self.down
     remove_column :tasks, :is_priority, :boolean
  end
end
