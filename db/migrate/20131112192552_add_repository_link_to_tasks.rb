class AddRepositoryLinkToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :repository_link, :string
  end
  
  def self.down
     remove_column :tasks, :repository_link, :string
  end
end
