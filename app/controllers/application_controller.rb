class ApplicationController < ActionController::Base
  #include SslRequirement
  #include RedirectBack
  
  protect_from_forgery
  helper_method :current_user, :current_project, :null_project_session, :ref, :current_role, :admin_role
  
  def index
    if current_user
      redirect_to dashboard_url
    else
      redirect_to log_in_url
    end
  end
  
  private
  
  def current_user
    @current_user ||= Person.find(session[:user_id]) if session[:user_id]
  end

  def current_project
    project_id = params[:project_id] || params[:id]
    session[:project_id] = project_id
    @current_project = Project.find(project_id)
  end
  
  def null_project_session
    session[:project_id] = nil
  end  
  
  def current_role
    @current_role = Permission.where(:project_id => current_project.id, :person_id => current_user.id)
    @current_role = @current_role.first
    if @current_role
      @current_role = @current_role.role.name
    end
  end
  
  def admin_role
    @admin_role = current_user.is_system_admin
  end
  
  def ref
    @ref = URI.parse(controller.request.env["HTTP_REFERER"])
  end
  
  
end

