class PermissionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @permission = Permission.new
    @people = Person.is_active
    @project_people = current_project.people.is_active
    
    @people = Permission.where(:project_id => current_project.id)
    #@people = Person.find_by_sql("select * from people where id in ( select person_id from permissions ) and is_active = '1' ")
        
    @roles = Role.all
    @admin_roles = Permission.where(:project_id => current_project.id, :role_id => '1')
    @user_roles = Permission.where(:project_id => current_project.id, :role_id => '2')
    @spec_roles = Permission.where(:project_id => current_project.id, :role_id => '3')
  end

  
  def update_role
    @permission = Permission.where(:project_id => params[:project_id], :person_id => params[:person_id])
    @permission = @permission.first
    @permission.role_id = params[:role_id]
    @permission.save
    respond_to do |format|
      format.html{redirect_to project_permissions_url(:project_id => current_project.id)}
    end
  end
end  