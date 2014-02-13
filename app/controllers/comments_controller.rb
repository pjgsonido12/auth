class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  # POST /comments
  def create
    task = Task.find(params[:task_id])
    @comment = task.comments.build(params[:comment])            
    @task = task
    @people = Person.where(['id = ? OR id = ?', current_user.id, task.assigned_to])
    @project = Project.where(:id => current_project.id).last  

    if @comment.save
      for person in @people
        UserMailer.comment_task(person, @project, @task, @comment).deliver
       end
      flash[:notice] = "You have successfully posted your comment."
       redirect_to project_task_url(current_project,task)
     end 
  end
  
end
