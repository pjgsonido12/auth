class ProjectRole < ActiveRecord::Base
  attr_accessible :person_id, :project_id, :role_id
  
  belongs_to :person
  belongs_to :role
  belongs_to :project
end
