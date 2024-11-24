Rails.application.routes.draw do
  root "home#top"

  get "sign_up", to: "users#new"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, param: :uuid, path: '/', only: [:new, :create, :show] do
    resources :posts,param: :uuid, path: '/'
  end
  resources :posts, only: [:index,]
    # collection do
      # get :search
    # end
    # resources :searchs, only: %i[create destroy]
end
