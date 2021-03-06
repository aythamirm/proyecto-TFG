 Prototype::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  root :to => 'tasks#index'
  ActiveAdmin.routes(self)
  
  devise_for :users, :controllers => { :sessions => "users/sessions", registrations: "users/registrations" }
  

  # The priority is based upon order of creation:
  # first created -> highest priority.
  resources :projects
  resources :tasks do
    get '/start_task' => "tasks#start", :as => :start_task
    get '/finish_task' => "tasks#finish", :as => :finish_task

    
    resources :interruptions
    post '/interruptions' => "interruptions#create", :as => :create_interruption
    get  '/interruptions_stop'=> "interruptions#stop_interruption", :as => :stop_interruption
  end   
  get '/state_task' => "tasks#state", :as => :state_task
  delete '/trash_task' => "tasks#trash", :as => :trash_task
  get '/reload_month' => "tasks#reload_month", :as => :reload_month
  get '/reload_tree' => "tasks#reload_tree", :as => :reload_tree
  
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end
   
   resources :nodes do
    collection do
      get :manage

      # required for Sortable GUI server side actions
      post :rebuild
    end
   end 
  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
