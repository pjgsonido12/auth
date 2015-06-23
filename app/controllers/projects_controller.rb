class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :null_project_session
  
  def index
    @projects = Project.is_active
  end
  
  def overview
    @project = Project.find(params[:id])    
  end
  
  def reports
    @tasks = Task.eager_load(:project).where("projects.is_active = ? AND tasks.is_active = ?", true, true).task_stat(params[:task_stat],params[:start_date],params[:end_date])
    @grouped_tasks = @tasks.group_by &:project
    @projects = current_user.projects.is_active
    @task_statuses = TaskStatus.all
    
    respond_to do |format|
      format.html
      format.csv { send_data @grouped_tasks.to_csv }
      format.xls   { headers["Content-Disposition"] = "attachment; filename=\"#{Date.today}_reports.xls\"" } 
    end
  end
  
  def moved_statuses
      respond_to do |format|
         @task_name = TaskStatus.find_by_name(params[:task_stat])
         if params[:tasks]
           @task = Task.where(:id => params[:tasks])
           if @task_name = "Resolved"
             @task.update_all({:task_status_id => params[:task_stat]}, {:date_resolved => Date.today})   
           elsif @task_name = "Closed"
             @task.update_all({:task_status_id => params[:task_stat]}, {:date_resolved => Date.today}, {:date_completed => Date.today})   
           else
             @task.update_all({:task_status_id => params[:task_stat]})   
           end
           flash[:notice] = "You have successfully moved tasks to #{params[:tasks]}"
           format.html { redirect_to reports_url }
         else
           flash[:error] = "Please select task to move."
           format.html { redirect_to reports_url }
         end
     end
  end
  
  def dashboard  
    if admin_role && current_user.permissions.length == 0
      @tasks = Task.eager_load(:project).where("projects.is_active = ? AND tasks.is_active = ? AND tasks.task_status_id IN (?)", true, true, [2,4,5,6,7]).search(params[:search])    
    else
    #  @tasks = Task.all(:joins => :project, :conditions => { :projects => { :is_active => true }, :tasks => {:assigned_to => current_user, :is_active => true, :task_status_id => [2,4,5,6,7]} }, :order => "tasks.due_date DESC") 
      @tasks = Task.eager_load(:project).where("projects.is_active = ? AND tasks.assigned_to = ? AND tasks.is_active = ? AND tasks.task_status_id IN (?)", true, current_user, true, [2,4,5,6,7]).search(params[:search])
    end
    @grouped_tasks = @tasks.group_by &:project
    @projects = current_user.projects.is_active
  end
  
  def overdue
    @tasks = Task.find(:all, :joins => :project, :conditions => ['projects.is_active = ? AND tasks.is_active = ? AND tasks.task_status_id <> ? AND tasks.is_priority = ? AND (((date(tasks.date_resolved) - tasks.due_date) > ? AND (tasks.task_status_id IN (?))) OR (tasks.due_date < ? AND (tasks.task_status_id IN (?))))', 1, 1, 1, 1, 0, [3, 4], Date.today, [1, 2, 5, 6, 7]], :order => "tasks.due_date DESC")   
    @grouped_tasks = @tasks.group_by &:project
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
