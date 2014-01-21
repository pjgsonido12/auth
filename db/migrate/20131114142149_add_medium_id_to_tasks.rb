class AddMediumIdToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :medium_id, :integer
  end
  
  def self.down
     remove_column :tasks, :medium_id, :integer
  end
end
