Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :user_added_list
  root 'getting_a_twitter_list#welcome'
  get 'auth/twitter/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get '/list', to: 'getting_a_twitter_list#index'
  get '/getting_a_twitter_list', to: 'getting_a_twitter_list#twitter_list'
  get '/search', to: 'user_added_list#search'
  get '/user_added_list', to: 'user_added_list#create'
  get '/search', to: 'user_added_list#find_new_user_to_add'
  # get '/list_members', to: 'user_added_list#list_members', as: "list_members"
  get '/index', to: 'user_added_list#index'
  get "/list_members/:list_id" => 'user_added_list#list_members', as: "list_members" 

  get "/list_members/:list_id/:id" => 'user_added_list#remove_list_members', as: "remove_list_members"
  get 'thanks' => 'user_added_list#thanks'

  # get "/list_members/:list_id/:id" => 'user_added_list#create_new_list', as: "create_new_list"

  # get "/list_members/:list_id/:id" => 'user_added_list#add_list_members', as: "add_list_members"


  # get  'getting_a_twitter_list#index'
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
