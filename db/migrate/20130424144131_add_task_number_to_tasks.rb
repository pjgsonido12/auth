class AddTaskNumberToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :task_number, :integer
  end
  
  def self.down
     remove_column :tasks, :task_number, :integer
  end
end
