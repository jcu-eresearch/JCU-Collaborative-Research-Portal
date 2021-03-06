JcuCollaborativeResearchPortal::Application.routes.draw do
  # Posts can't be edited/updated
  resources :posts, :except => [:update, :edit] do
    # Posts have comments (comments can only be created, and destroyed)
    resources :comments, :only => [:create, :destroy] do
    end
  end

  # A researcher cannot be created or destroyed.
  resources :researchers, :except => [:destroy, :new, :create] do
    member do
      get 'account'
      get 'posts'
      put 'like_tag'
      put 'dislike_tag'
      put 'forget_tag'
    end
  end

  # A session can't be updated
  # It can only be created, and destroyed.
  resource :session, :only => [:new, :destroy]

  resource :textile, :only => [], do
    post 'preview'
  end

  resource :markdown, :only => [], do
    post 'preview'
  end

  resource :home, :only => [], do
    get 'index'
    get 'about'
    get 'support'
  end

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
  root :to => "homes#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
