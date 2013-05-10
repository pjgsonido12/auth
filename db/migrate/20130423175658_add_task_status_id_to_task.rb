class AddTaskStatusIdToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :task_status_id, :int
  end
  
  def self.down
     remove_column :tasks, :task_status_id, :int
  end
end
