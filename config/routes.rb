Rails.application.routes.draw do
  root "home#top"

  get 'sign_up', to: 'users#new'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :posts, only: [:index] #GETリクエストのみ対応
  resources :users, param: :uuid, only: [:new, :show, :create]
  #UUIDを使った投稿に関するルート設定
  resources :posts, param: :uuid, only: [:show, :new, :create, :edit, :update]
end
