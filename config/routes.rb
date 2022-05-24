Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#welcome"
  # Defines the root path route ("/")
  # root "articles#index"
  resources :shipping_companies, only: [:index, :show]
end
