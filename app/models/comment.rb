class Comment < ActiveRecord::Base
  attr_accessible :comment, :created_by, :is_active, :task_id, :updated_by
  
  belongs_to :task
  belongs_to :created_person, :class_name => "Person", :foreign_key => "created_by"
  
  scope :is_active, where(:is_active => true) 
end
