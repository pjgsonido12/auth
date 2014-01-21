class ProjectsController < ApplicationController
  before_filter :null_project_session
  
  def index
    @projects = Project.is_active
  end
  
  def overview
    @project = Project.find(params[:id])    
  end
  
  def new_task
    @tasks = Task.where(:task_status_id => 1, :is_active => 1)
    @projects = current_user.projects.is_active
    
    @overdue_tasks = Task.where(['is_active = ? AND is_priority = ? AND (((date(date_resolved) - due_date) > ? AND (task_status_id = ? OR task_status_id = ?)) OR (due_date < ? AND (task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ?)))', 1, 1, 0, 3, 4, Date.today, 1, 2, 5, 6, 7]).order("created_at DESC")
    @new_tasks = Task.where(:task_status_id => 1, :is_active => 1)
    @resolved_tasks = Task.where(:task_status_id => 4, :is_active => 1)
    @done_tasks = Task.where(:task_status_id => 3, :is_active => 1)
  end
  
  def resolved_task
    @tasks = Task.where(:task_status_id => 4, :is_active => 1).order("created_at DESC")
    @tasks = @tasks.paginate(:page => params[:page],:per_page => 10)  
    @projects = current_user.projects.is_active
    
    @overdue_tasks = Task.where(['is_active = ? AND is_priority = ? AND (((date(date_resolved) - due_date) > ? AND (task_status_id = ? OR task_status_id = ?)) OR (due_date < ? AND (task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ?)))', 1, 1, 0, 3, 4, Date.today, 1, 2, 5, 6, 7]).order("created_at DESC")
    @new_tasks = Task.where(:task_status_id => 1, :is_active => 1)
    @resolved_tasks = Task.where(:task_status_id => 4, :is_active => 1)
    @done_tasks = Task.where(:task_status_id => 3, :is_active => 1)
  end
  
  def done_task
    @tasks = Task.where(:task_status_id => 3, :is_active => 1).order("created_at DESC")
    @tasks = @tasks.paginate(:page => params[:page],:per_page => 10)
    @projects = current_user.projects.is_active
    
    @overdue_tasks = Task.where(['is_active = ? AND is_priority = ? AND (((date(date_resolved) - due_date) > ? AND (task_status_id = ? OR task_status_id = ?)) OR (due_date < ? AND (task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ?)))', 1, 1, 0, 3, 4, Date.today, 1, 2, 5, 6, 7]).order("created_at DESC")
    @new_tasks = Task.where(:task_status_id => 1, :is_active => 1)
    @resolved_tasks = Task.where(:task_status_id => 4, :is_active => 1)
    @done_tasks = Task.where(:task_status_id => 3, :is_active => 1)
  end
  
  def dashboard  
    @tasks = Task.where(['is_active = ? AND task_status_id <> ? AND assigned_to = ?', 1, 3, current_user]).order("created_at DESC")
    @tasks = @tasks.paginate(:page => params[:page],:per_page => 10)  
    @projects = current_user.projects.is_active
    
    @overdue_tasks = Task.where(['is_active = ? AND is_priority = ? AND (((date(date_resolved) - due_date) > ? AND (task_status_id = ? OR task_status_id = ?)) OR (due_date < ? AND (task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ?)))', 1, 1, 0, 3, 4, Date.today, 1, 2, 5, 6, 7]).order("created_at DESC")
    @new_tasks = Task.where(:task_status_id => 1, :is_active => 1)
    @resolved_tasks = Task.where(:task_status_id => 4, :is_active => 1)
    @done_tasks = Task.where(:task_status_id => 3, :is_active => 1)
  end
  
  def overdue
    # ALL OVERDUE TASK
    @tasks = Task.where(['is_active = ? AND is_priority = ? AND (((date(date_resolved) - due_date) > ? AND (task_status_id = ? OR task_status_id = ?)) OR (due_date < ? AND (task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ?)))', 1, 1, 0, 3, 4, Date.today, 1, 2, 5, 6, 7]).order("created_at DESC")
    @tasks = @tasks.paginate(:page => params[:page],:per_page => 10)  
    @projects = current_user.projects.is_active
    
    @overdue_tasks = Task.where(['is_active = ? AND is_priority = ? AND (((date(date_resolved) - due_date) > ? AND (task_status_id = ? OR task_status_id = ?)) OR (due_date < ? AND (task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ? OR task_status_id = ?)))', 1, 1, 0, 3, 4, Date.today, 1, 2, 5, 6, 7]).order("created_at DESC")
    @new_tasks = Task.where(:task_status_id => 1, :is_active => 1)
    @resolved_tasks = Task.where(:task_status_id => 4, :is_active => 1)
    @done_tasks = Task.where(:task_status_id => 3, :is_active => 1)
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
