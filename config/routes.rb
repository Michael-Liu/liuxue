Liuxue::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => 'sessions'} do
    get "users/edit", :to => "registrations#edit", :as => "edit_user"
    get "users/edit_password", :to => "registrations#edit_password", :as => "edit_password_user"
    get "users/edit_avatar", :to => "registrations#edit_avatar", :as => "edit_avatar_user"
    get "users/edit_teacher", :to => "registrations#edit_teacher", :as => "edit_teacher"
    put "users/update_password", :to => "registrations#update_password", :as => "update_password_user"
    put "users/update_avatar", :to => "registrations#update_avatar", :as => "update_avatar_user"
    put "users/update", :to => "registrations#update", :as => "update_user"
    put "users/update_teacher", :to => "registrations#update_teacher", :as => "update_teacher"
  end

  devise_scope :user do
    match 'users/sign_out' => 'sessions#destroy'
    match 'logout' => 'sessions#destroy'
    match 'login' => 'sessions#new'
    # match 'edit_password' => 'registrations#edit_password'
    # match 'edit_avatar' => 'registrations#edit_avatar'
    # match '/login' => 'devise/sessions#new'
  end

  match '/home' => 'users#home'
  match '/:id/home' => 'users#show'

  resources :countries do
    resources :schools
    resources :users do
      collection do
        get :request_school
        get :request_visa
      end
    end
  end

  resources :users do
    resources :comments, :messages
  end

  resource :account

  # resource :users do
  #   member do
  #     get :edit_password
  #     put :update_password
  #     get :edit_avatar
  #     put :update_avatar
  #   end
  # end

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
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
