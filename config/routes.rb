Pdigital::Application.routes.draw do


  scope "/(:locale)" do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)


    devise_for :users
    resources :articles, :categories, :polls, :the_mosts
  end

  root :to => 'articles#index'

  resources :articles, :categories, :article_comments, :polls, :the_mosts

  match 'article_comments/vote/:id/:vote_type' => 'article_comments#vote', :as => :vote
  match 'polls/vote/:id/:id_option' => 'polls#vote', :as => :vote_poll
  
  # match 'polls/vote_result/:id' => 'polls#vote_result', :as => :vote_result
  # match 'polls/poll_options/:id' => 'polls#poll_options', :as => :poll_options
  
  mount ImperaviRails::Engine => "/imperavi"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
