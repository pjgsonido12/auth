class Permission < ActiveRecord::Base
  attr_accessible :project_id, :person_id, :id, :role_id
  
  validates_uniqueness_of :person_id, scope: :project_id
  
  belongs_to :project
  belongs_to :person, :conditions => {:is_active => true}
  belongs_to :role
  
end  
