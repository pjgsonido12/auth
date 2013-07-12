class RolesController < ApplicationController
  def index
    @project_role = ProjectRole.new
    #@people = Person.is_active
    
    @project_stat = ProjectRole.where(:project_id => current_project.id)
    @people = Person.find_by_sql("select * from people where id not in ( select person_id from project_roles ) and is_active = '1' ")
        
    @roles = Role.all
    @admin_roles = ProjectRole.where(:project_id => current_project.id, :role_id => '1')
    @user_roles = ProjectRole.where(:project_id => current_project.id, :role_id => '2')
    @spec_roles = ProjectRole.where(:project_id => current_project.id, :role_id => '3')
    
  end
  
  def create
    @project_role = ProjectRole.new(params[:project_role])
    
    if @project_role.save
      redirect_to project_roles_url
    else
      render :back
    end    
  end
   
  def destroy
    @project_role = ProjectRole.find(params[:id])
    @project_role.destroy

    redirect_to(project_roles_url)
  end
end
