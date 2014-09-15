Rails.application.routes.draw do
  
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
  get '/index', to: 'user_added_list#index'
  get "/list_members/:list_id" => 'user_added_list#list_members', as: "list_members" 
  get "/list_members/:list_id/:id" => 'user_added_list#remove_list_members', as: "remove_list_members"
  get 'thanks' => 'user_added_list#thanks', as: "thanks"
end
