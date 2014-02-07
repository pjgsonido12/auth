class PeopleController < ApplicationController
   before_filter :authenticate_user!
   before_filter :null_project_session
    
    def index
      @people = Person.is_active
      @projects = Project.is_active
    end
    
    def new
      @person = Person.new
      @projects = Project.is_active
    end
    
    def show
      @person = Person.find(params[:id])
    end  
    
    def create
      @person = Person.new(params[:person])
      if @person.save
        flash[:notice] = "You have successfully added new person."
        redirect_to people_url
      else
        render "new"
      end
    end
    
    def edit
      @person = Person.find(params[:id],:include => {:permissions => :project})
      @projects = Project.is_active
    end
    
    def update
      @person = Person.find(params[:id])

      respond_to do |format|
        if @person.update_attributes(params[:person])
          flash[:notice] = "You have successfully updated person information."
          format.html { redirect_to person_url }
          format.xml  { head :ok }
        else
          format.html { render :edit }
          format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
        end
      end
    end
    
    def destroy
      @person = Person.find(params[:id])
      @person.is_active = false
      @person.save

      redirect_to(people_url)
    end
    
    def cancel
      @person = Person.find(params[:id])
      @person.is_active = false
      @person.save
      
      redirect_to(people_url)
    end  
     
  end