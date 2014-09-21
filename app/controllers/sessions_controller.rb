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
    @tour = Tour.new
    @tours = Tour.all
  end
  
  def payment
    @tour = Tour.new
  end
  
  def add_payment
    @tour = Tour.new(params[:tour])
    if @tour.save
      flash[:notice] = "You have a payment."
      redirect_to mansionitas_url
    else
      render "mansionitas"
    end
  end
end


