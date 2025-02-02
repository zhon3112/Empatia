Rails.application.routes.draw do
  root "static_pages#top"

  get 'terms', to: 'pages#terms'
  get 'privacy_policy', to: 'pages#privacy_policy'

  get 'sign_up', to: 'users#new'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: [:new, :show, :create]

  #resources :my_posts, only: [:index]
  resources :my_likes, only: [:index]

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
end