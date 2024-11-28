Rails.application.routes.draw do
  root "home#top"

  get "sign_up", to: "users#new"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :posts, only: [:index]
  resources :users, param: :uuid, path: '/', only: [:new, :show, :create]
  resources :posts,param: :uuid, path: '/',only: [:show]
end
