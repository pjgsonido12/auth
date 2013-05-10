Auth::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  get "tasks/new"

  get "project/new"
  get "dashboard/new"

  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "people#new", :as => "sign_up"
  get "log_out" => "sessions#destroy", :as => "log_out"
  match 'dashboard' => 'projects#dashboard', :as => 'dashboard'
  match '/permissions/update_role' => 'permissions#update_role', :as => 'update_role', :via => [:put]
  
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
        put :change
      end
      
      collection do
        get :new_task
        get :my_task
        get :done_task
        get :resolved_task
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
 