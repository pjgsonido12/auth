class AddTaskTypeIdToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :task_type_id, :integer
  end
  
  def self.down
     remove_column :tasks, :task_type_id, :integer
  end
end
