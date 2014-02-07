class Task < ActiveRecord::Base
  attr_accessible :assigned_to, :created_by, :description, :due_date, :is_active, :project_id, :status, :title, :updated_by, :id, :task_status_id, :task_number, :date_completed, :person_id, :severity_id, :repository_link, :is_priority, :task_type_id, :date_resolved, :medium_id, :error_count, :reassigned_count, :reopen_count

  belongs_to :project
  has_many :comments
  belongs_to :task_status
  belongs_to :task_type
  belongs_to :severity
  belongs_to :medium
  belongs_to :assigned_person,:class_name => "Person", :foreign_key => "assigned_to"
  belongs_to :created_person,:class_name => "Person", :foreign_key => "created_by"
  belongs_to :source_person,:class_name => "Person", :foreign_key => "person_id"
    
  scope :is_active, where(:is_active => true) 
  
  validates_presence_of :title, :due_date
  validates_uniqueness_of :title
end
