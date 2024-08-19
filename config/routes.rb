Rails.application.routes.draw do
  resources :posts
  
  root "home#top"

  resources :users, only: %i[new create]

  get "sign_up", to: "users#new"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
