Rails.application.routes.draw do
  root "home#top"

  get "sign_up", to: "users#new"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, param: :uuid, path: '/', only: [:new, :show, :create, :edit, :update] do
    resources :posts,param: :uuid, path: '/'
  end
  #get 'users/posts', param: :uuid, path, to: 'users#show', as: :mypage
  resources :posts, only: [:index]
end
