Rails.application.routes.draw do
  root "todos#index"

  resources :todos
  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]

  get "signup", to: "users#new", as: :signup
  post "signup", to: "users#create"
  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  get "up" => "rails/health#show", as: :rails_health_check
end
