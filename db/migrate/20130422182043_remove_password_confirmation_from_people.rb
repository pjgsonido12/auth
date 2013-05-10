class RemovePasswordConfirmationFromPeople < ActiveRecord::Migration
  def self.down
    remove_column :people, :password_confirmation, :string   
  end
end
