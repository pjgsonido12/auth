class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :id
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password
      t.boolean :is_active

      t.timestamps
    end
  end
end
