class AddDateCompletedToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :date_completed, :date
  end
  
  def self.down
     remove_column :tasks, :date_completed, :date
  end
end
