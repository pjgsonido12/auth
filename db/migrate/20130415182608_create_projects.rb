class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :id
      t.string :name
      t.string :description
      t.integer :createdby
      t.integer :updatedby
      t.boolean :is_active

      t.timestamps
    end
  end
end
