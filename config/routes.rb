Auth::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  get "tasks/new"

  get "project/new"
  get "dashboard/new"

  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "people#new", :as => "sign_up"
  get "log_out" => "sessions#destroy", :as => "log_out"
  match 'dashboard' => 'projects#dashboard', :as => 'dashboard'
  match 'overdue' => 'projects#overdue', :as => 'overdue'
  match 'reports' => 'projects#reports', :as => 'reports'
  match '/permissions/update_role' => 'permissions#update_role', :as => 'update_role', :via => [:put]
  match "/", :to => "application#index", :as => :application
  post '/email_processor' => 'griddler/emails#create'
  
  match 'exam' => 'sessions#exam', :as => 'exam'
  match 'mansionitas' => 'sessions#mansionitas', :as => 'mansionitas'
  
  root :to => "sessions#new"
    
  resources :people do
    member do
      put :cancel
    end  
  end  
  
  resources :sessions
  
  resources :projects do
    member do
      get :overview
      put :cancel
    end  
    resources :tasks do
      member do
        put :cancel
        put :update_task
        put :change
        put :remove
      end
      
      collection do
        get :overdue
        get :reports
      end  
      resources :comments
    end
    resources :permissions
    # do
      #member do
      #  put :update_role
      #end
    #end
    resources :roles
  end   
  
  mount Ckeditor::Engine => "/ckeditor" 
 end
 