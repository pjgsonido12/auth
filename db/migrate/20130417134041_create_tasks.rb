class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.integer :project_id
      t.integer :created_by
      t.integer :updated_by
      t.integer :assigned_to
      t.integer :status
      t.timestamps :due_date
      t.boolean :is_active

      t.timestamps
    end
  end
end
