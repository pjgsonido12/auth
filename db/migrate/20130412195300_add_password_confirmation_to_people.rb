class AddPasswordConfirmationToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :password_confirmation, :string
  end
  
  def self.down
     remove_column :people, :password_confirmation, :string   
  end
end
