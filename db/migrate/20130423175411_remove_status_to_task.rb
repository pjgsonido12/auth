class RemoveStatusToTask < ActiveRecord::Migration
  def self.down
    remove_column :task, :status
  end
end
