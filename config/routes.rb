Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#welcome"
  # Defines the root path route ("/")
  # root "articles#index"
  resources :shipping_companies, only: [:index, :show, :new, :create, :edit, :update], shallow: true do
    resources :vehicles, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :price_table, only: [:index, :update]
    resources :price_line, only: [:new, :create, :destroy]
    resources :delivery_time_table, only: [:index]
    resources :delivery_time_line, only: [:new, :create, :destroy]
    resources :order, only: [:index, :show, :new, :create, :update] do
      post 'new_ul', on: :member
    end
    resources :update_line, only: [:create]

    get 'budget_query', on: :collection
    get 'budget_response', on: :collection
    patch 'status_change', on: :member
  end  
  get '/search', to: "order#search"
end
