class AddIsSystemAdminToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :is_system_admin, :boolean
  end
  
  def self.down
     remove_column :people, :is_system_admin, :boolean
  end
end
