class ProjectsController < ApplicationController
  before_filter :null_project_session
  
  def index
    @projects = Project.is_active
  end
  
  def overview
    @project = Project.find(params[:id])
    
  end
  
  def dashboard
    @projects = current_user.projects.is_active
  end
  
  def new
     @project = Project.new
     @roles = Role.all
     @people = Person.is_active
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = "You have successfully added new project."
      redirect_to projects_url
    else
      render "new"
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = "You have successfully updated project information."
        format.html { redirect_to overview_project_url }
        format.xml  { head :ok }
      else
        format.html { render :edit }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.is_active = false
    @project.save

    redirect_to(projects_url)
  end
  
  def cancel
    @project = Project.find(params[:id])
    @project.is_active = false
    @project.save
    
    redirect_to(projects_url)
  end

end
