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
  
  def self.search(search)
    if search
      person_id = Person.where('firstname LIKE ?',"%#{search}%").map(&:id)
      find(:all, :order => "due_date DESC", :joins => :task_status, :conditions => ['task_statuses.name LIKE ? OR title LIKE ? OR assigned_to IN (?)', "%#{search}%", "%#{search}%",person_id])
    else
      find(:all, :order => "due_date DESC")
    end
  end
  
  def self.task_stat(task_stat,start_date,end_date)
    if task_stat
      if task_stat == "Closed" || task_stat == "Resolved"
        find(:all, :order => "due_date DESC", :joins => :task_status, :conditions => ['task_statuses.name = ? AND date_resolved BETWEEN ? AND ?', "#{task_stat}", "#{start_date.to_date}", "#{end_date.to_date}"])
      else
        find(:all, :order => "due_date DESC", :joins => :task_status, :conditions => ['task_statuses.name = ? AND due_date BETWEEN ? AND ?', "#{task_stat}", "#{start_date.to_date}", "#{end_date.to_date}"])
      end
    else
      find(:all, :order => "due_date DESC")
    end
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |task|
        csv << task.attributes.values_at(*column_names)
      end
    end
  end
end
