Rails.application.routes.draw do
  root "home#top"

  resources :users, only: [:new, :create, :show] 
  resources :posts 

  get "sign_up", to: "users#new"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'my_post', to: 'post#user_index', as: 'post_user_index'
end
