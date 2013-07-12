class ChangeLongtextForDescriptionFromProjects < ActiveRecord::Migration
  def self.up
    change_column :projects, :description, :text, :limit => 4294967295
  end

  def self.down
    change_column :projects, :description, :string
  end
end
