class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment
      t.integer :task_id
      t.integer :created_by
      t.integer :updated_by
      t.boolean :is_active

      t.timestamps
    end
  end
end
