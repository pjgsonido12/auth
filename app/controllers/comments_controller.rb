class CommentsController < ApplicationController
  # POST /comments
  def create
    task = Task.find(params[:task_id])
    @comment = task.comments.build(params[:comment])
    
    if @comment.save
      flash[:notice] = "You have successfully posted your comment."
      redirect_to project_task_url(current_project,task)
    else
         
    end
  end
  
end
