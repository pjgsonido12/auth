class Person < ActiveRecord::Base  
  attr_accessible :email, :firstname, :id, :is_active, :lastname, :password, :password_confirmation, :accessible_project_ids, :auth_token, :is_system_admin
  attr_accessor :accessible_project_ids
  
  before_create { generate_token(:auth_token) }
  
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_length_of :password, :minimum => 5
  validates_confirmation_of :password
  
  has_many :permissions
  has_many :projects, :through => :permissions, :conditions => {:is_active => true}
  scope :is_active, where(:is_active => true) 
  has_many :tasks
  has_many :comments
  
  has_many :project_roles
  scope :is_role_active, where(:is_active => true) 
  #scope :is_role_active, where("people.is_active = '1' and project_roles.project_id = '23'")
  
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == password
      user
    else
      nil
    end
  end
  
  def name
    firstname + " " + lastname
  end
  
  #instance methods
  
  def accessible_project_ids
      @accessible_project_ids ||= projects.map {|p| p.id}
  end

  def accessible_project_ids=(project_ids=[])
      project_ids.map! {|id| id.to_i}
      # Grant access...
      access_to_add = project_ids - accessible_project_ids
      access_to_add.each {|project_id| permissions.build(:project_id => project_id, :role_id => 2)}
      # Revoke access...
      access_to_remove = accessible_project_ids - project_ids    
      permissions.where(:project_id => access_to_remove).delete_all
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Person.exists?(column => self[column])
  end
end
