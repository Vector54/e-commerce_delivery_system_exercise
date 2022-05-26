Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#welcome"
  # Defines the root path route ("/")
  # root "articles#index"
  resources :shipping_companies, only: [:index, :show, :new, :create]
  resources :vehicles, only: [:index, :new, :create]
  resources :price_table, only: [:show]
  resources :price_line, only: [:new, :create]
  resources :delivery_time_table, only: [:show]
  resources :delivery_time_line, only: [:new, :create]
end
