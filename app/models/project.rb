class Project < ActiveRecord::Base
  attr_accessible :createdby, :description, :id, :is_active, :name, :updatedby
  
  has_many :permissions
  has_many :people, :through => :permissions, :conditions => { :is_active => true }
  belongs_to :creator, :class_name => "Person", :foreign_key => "createdby"
  has_many :tasks
  
  scope :is_active, where(:is_active => true) 
  has_many :project_roles
  
  validates_presence_of :name
end
