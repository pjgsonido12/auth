class AddDateResolvedToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :date_resolved, :date
  end
  
  def self.down
     remove_column :tasks, :date_resolved, :date
  end
end
