class CreateTasksStatuses < ActiveRecord::Migration
  def change
    create_table :tasks_statuses do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
