class Task < ActiveRecord::Base
  attr_accessible :assigned_to, :created_by, :description, :due_date, :is_active, :project_id, :status, :title, :updated_by, :id, :task_status_id, :task_number, :date_completed

  belongs_to :project
  has_many :comments
  belongs_to :task_status
  belongs_to :assigned_person,:class_name => "Person", :foreign_key => "assigned_to"
  belongs_to :created_person,:class_name => "Person", :foreign_key => "created_by"
    
  scope :is_active, where(:is_active => true) 
  
end
