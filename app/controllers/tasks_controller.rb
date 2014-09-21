class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_project!, :except => [:new, :create]
  
    def index
      @tasks = current_project.tasks.is_active.search(params[:search])
      @grouped_tasks = @tasks.group_by &:task_status
    end
            
    def show
      respond_to do |format|
        format.html {
        @task = Task.find(params[:id])
        @comment = @task.comments.build
        @comments = Comment.where(:task_id => @task.id)
        @people = Person.is_active
        @permissions = Permission.where(:project_id => current_project.id)
      
        if @task.task_status.name == 'Re-Assigned' || @task.task_status.name == 'Re-Open'
          @task_statuses = TaskStatus.task_accepted
        elsif @task.task_status.name == 'Assigned'
          @task_statuses = TaskStatus.task_assigned
        elsif @task.task_status.name == 'Accepted'
          @task_statuses = TaskStatus.task_accepted
        elsif @task.task_status.name == 'Resolved'
          @task_statuses = TaskStatus.task_resolved
        elsif @task.task_status.name == 'New'
          @task_statuses = TaskStatus.task_new   
        elsif @task.task_status.name == 'Invalid'
          @task_statuses = TaskStatus.task_invalid
        else
          @task_statuses = TaskStatus.task_done     
        end
        } # show.html.erb
        
      end
    end
    
    def new
      @task = Task.new
      @people = Person.is_active
      @permissions = Permission.where(:project_id => current_project.id)
      
      tasks = current_project.tasks
      if tasks.length > 0
        @task_number = tasks.last.task_number + 1
      else
        @task_number = 1  
      end  
      @projects = Project.is_active
      @severities = Severity.all
      @task_types = TaskType.all
      @media = Medium.all
    end

    def create
      @people = Person.is_active
      @permissions = Permission.where(:project_id => current_project.id)
      
      tasks = current_project.tasks
      if tasks.length > 0
        @task_number = tasks.last.task_number + 1
      else
        @task_number = 1  
      end  
      @projects = Project.is_active
      @severities = Severity.all
      @task_types = TaskType.all
      @media = Medium.all
      @task = Task.new(params[:task]) 
      @project = Project.where(:id => current_project.id).last        
      if @task.save
        flash[:notice] = "You have successfully created new task."
        redirect_to project_tasks_url
      else
        render "new"
      end
    end    
    
    def edit
       @task = Task.find(params[:id])
       @severities = Severity.all
       @people = Person.is_active
       @task_types = TaskType.all
       @media = Medium.all
    end

    def update_task
      @task = Task.find(params[:id])
      @severities = Severity.all
      @people = Person.is_active
      @task_types = TaskType.all
      @media = Medium.all
        respond_to do |format|
         if @task.update_attributes(params[:task])
           flash[:notice] = "You have successfully updated task information."
           format.html { redirect_to project_task_url }
           format.xml  { head :ok }
         else
           format.html { render :edit }
           format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
         end
       end
     end
     
     def update
       @task = Task.find(params[:id])
       @severities = Severity.all
       @people = Person.is_active
       @task_types = TaskType.all
       @media = Medium.all
       if params[:people].nil? 
         flash[:alert] = "Please check atleast one person."
         redirect_to :back
       else  
         @people = Person.find(params[:people])
         @project = Project.where(:id => current_project.id).last  
         respond_to do |format|
          if @task.update_attributes(params[:task])
            for person in @people
              #UserMailer.updated_task(person, @project, @task).deliver
            end
            flash[:notice] = "You have successfully updated task information."
            if @task.task_status.name == 'Resolved'
              format.html { redirect_to dashboard_url }
            elsif @task.task_status.name == 'Closed' || @task.task_status.name == 'Re-Open'
              format.html { redirect_to project_tasks_url(current_project) }
            else
              format.html { redirect_to project_task_url }
            end
            format.xml  { head :ok }
          else
            format.html { render :edit }
            format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
          end
        end
      end
      end

     def destroy
       @task = Task.find(params[:id])
       @task.is_active = false
       @task.save

       redirect_to(project_tasks_url)
     end
     
     def cancel
       @task = Task.find(params[:id])
       @task.is_active = false
       @task.save

       redirect_to(project_tasks_url)
     end
     
     def remove
       task = Task.find(params[:task_id])
       @comment = Comment.find(params[:id])
       @comment.is_active = false
       @comment.save

       flash[:notice] = "You have successfully removed your comment."
       redirect_to project_task_url(current_project,task)
     end    
     
end
