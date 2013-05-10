class TasksController < ApplicationController
    def index
      @tasks = current_project.tasks.where(['is_active = ? AND task_status_id <> ?', 1, 3])
    end
    
    def done_task
      @tasks = current_project.tasks.where(['is_active = ? AND task_status_id = ?', 1, 3])
    end
    
    def resolved_task
      @tasks = current_project.tasks.where(['is_active = ? AND task_status_id = ?', 1, 4])
    end
    
    def new_task
      @tasks = current_project.tasks.where(:task_status_id => 1, :is_active => 1)
    end
    
    def my_task
      @tasks = current_project.tasks.where(['is_active = ? AND task_status_id <> ? AND assigned_to = ?', 1, 3, current_user.id])
    end
    
    
    def show
      @task = Task.find(params[:id])
      @comment = @task.comments.build
      @comments = Comment.where(:task_id => @task.id)
      @people = Person.is_active
      @permissions = Permission.where(:project_id => current_project.id)
      
      if @task.task_status.name == 'Assigned' || @task.task_status.name == 'Re-Assigned' || @task.task_status.name == 'Re-Open'
        @task_statuses = TaskStatus.task_assigned
      elsif @task.task_status.name == 'Accepted'
        @task_statuses = TaskStatus.task_accepted
      elsif @task.task_status.name == 'Resolved'
        @task_statuses = TaskStatus.task_resolved         
      else
        @task_statuses = TaskStatus.task_done     
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
    end

    def create
      @task = Task.new(params[:task])
      if params[:people].nil?
        flash[:notice] = "Please check atleast one person."
        redirect_to :back
      else  
        @people = Person.find(params[:people])
       if @task.save
         for person in @people
           UserMailer.registration_confirmation(person).deliver
         end
         flash[:notice] = "You have successfully created new task."
         redirect_to project_tasks_url
       else
         render :back
       end
     end
    end    
    
    def edit
       @task = Task.find(params[:id])
       @people = Person.is_active
    end

    def update
      @task = Task.find(params[:id])
      if params[:people].nil?
        flash[:notice] = "Please check atleast one person."
        redirect_to :back
      else  
        @people = Person.find(params[:people])
        respond_to do |format|
         if @task.update_attributes(params[:task])
           for person in @people
             UserMailer.registration_confirmation(person).deliver
           end
           flash[:notice] = "You have successfully updated task information."
           format.html { redirect_to project_task_url }
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
     
end
