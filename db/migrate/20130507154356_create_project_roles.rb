class CreateProjectRoles < ActiveRecord::Migration
  def change
    create_table :project_roles do |t|
      t.integer :person_id
      t.integer :project_id
      t.integer :role_id

      t.timestamps
    end
  end
end
