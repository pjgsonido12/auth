class SessionsController < ApplicationController
  def new
  end
  
  def create
      user = Person.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to dashboard_url
      else
        flash[:error] = "Invalid email or password"
        render "new"
      end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  
  def mansionitas
    @tours = Task.where(:project_id => 29) #NA
  end

end


