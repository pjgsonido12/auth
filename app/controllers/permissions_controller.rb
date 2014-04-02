class PermissionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_project!
  def index
    @permission = Permission.new
    @project_people = current_project.people.is_active    
    @people = Permission.where(:project_id => current_project.id)  
    @add_people = Person.find_by_sql("SELECT * from people where id not in (SELECT person_id from permissions where permissions.project_id = #{current_project.id}) and people.is_active = '1' ")     
    @roles = Role.all
    @admin_roles = Permission.where(:project_id => current_project.id, :role_id => '1')
    @user_roles = Permission.where(:project_id => current_project.id, :role_id => '2')
    @spec_roles = Permission.where(:project_id => current_project.id, :role_id => '3')
  end

  def create
    @permission = Permission.new(params[:permission])
    if @permission.save
      redirect_to project_permissions_url
    else
      render "new"
    end
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