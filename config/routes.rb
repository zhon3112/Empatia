Rails.application.routes.draw do
  root "static_pages#top"

  get 'terms', to: 'pages#terms'
  get 'privacy_policy', to: 'pages#privacy_policy'

  get 'sign_up', to: 'users#new'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :posts, only: [:index] #GETリクエストのみ対応
  resources :users, only: [:new, :show, :create]
  resources :posts, only: [:new, :create, :edit, :update, :destroy]
end
