class ChangeLongtextForDescriptionFromTasks < ActiveRecord::Migration
  def self.up
    change_column :tasks, :description, :text, :limit => 4294967295
  end

  def self.down
    change_column :tasks, :description, :string
  end
end
