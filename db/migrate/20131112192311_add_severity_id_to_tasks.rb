class AddSeverityIdToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :severity_id, :integer
  end
  
  def self.down
     remove_column :tasks, :severity_id, :integer
  end
end
