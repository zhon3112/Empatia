Rails.application.routes.draw do
  root "home#top"

  resources :users, only: [:new, :create, :show] do
    resources :posts 
  end
  resources :posts, only: [:index]

  get "sign_up", to: "users#new"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
