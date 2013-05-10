class Role < ActiveRecord::Base
  attr_accessible :description, :name
  
  has_many :project_roles
  has_many :permissions

end
