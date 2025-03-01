Rails.application.routes.draw do
  get 'oauths/oauth'

  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider

  get 'oauths/callback'
  get 'my_posts/index'
  root "static_pages#top"

  get 'terms', to: 'pages#terms'
  get 'privacy_policy', to: 'pages#privacy_policy'

  get 'sign_up', to: 'users#new'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: [:new, :create]

  resources :my_posts, only: [:index]
  resources :my_likes, only: [:index]

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
end