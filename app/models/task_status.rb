class TaskStatus < ActiveRecord::Base
  attr_accessible :description, :name, :task_id
  
  has_many :tasks
  scope :task_assigned, where("task_statuses.name = 'Re-Assigned' or task_statuses.name = 'Accepted' ")
  scope :task_accepted, where("task_statuses.name = 'Re-Assigned' or task_statuses.name = 'Resolved' ")
  scope :task_resolved, where("task_statuses.name = 'Re-Assigned' or task_statuses.name = 'Done' ")
  scope :task_done, where("task_statuses.name = 'Re-Open' or task_statuses.name = 'Done' ")
end
