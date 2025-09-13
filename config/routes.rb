Rails.application.routes.draw do
  root "sessions#new"

  # resources :users, only: [:new, :create, :show, :edit, :update]
  # resources :sessions, only: [:new, :create, :destroy]
  get    "/login",  to: "sessions#new",     as: "login"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"
  # for logout
  # delete '/logout', to: 'sessions#destroy'

  resources :posts, only: [ :new, :create, :index, :show, :destroy ] do # Nested routes for comments
    resources :comments, only: [ :create, :destroy ] # Nested routes for comments under posts
    resources :likes, only: [ :create, :destroy ] # Nested routes for likes under posts
    post "toggle_like", to: "posts#toggle" # Custom route for toggling likes on a post
  end

  resources :users, only: [ :new, :create, :show, :edit, :update ] do # Nested routes for user profiles
    member do # Routes for following and followers
      get :following, :followers # GET /users/:id/following and GET /users/:id/followers
      post :follow
      delete :unfollow
    end
  end









  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
