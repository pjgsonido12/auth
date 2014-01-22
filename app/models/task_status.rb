class TaskStatus < ActiveRecord::Base
  attr_accessible :description, :name, :task_id
  
  has_many :tasks
  scope :task_new, where("task_statuses.name = 'Invalid' or task_statuses.name = 'Assigned' ")
  scope :task_assigned, where("task_statuses.name = 'Accepted' or task_statuses.name = 'New' ")
  scope :task_accepted, where("task_statuses.name = 'Resolved' ")
  scope :task_resolved, where("task_statuses.name = 'Re-Assigned' or task_statuses.name = 'Closed' ")
  scope :task_done, where("task_statuses.name = 'Re-Open' or task_statuses.name = 'Closed' ")
  scope :task_invalid, where("task_statuses.name = 'Assigned' ")
end
