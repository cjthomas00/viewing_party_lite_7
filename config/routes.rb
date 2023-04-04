Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  get "/register", to: "users#new"
  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
  get "/logout", to: "users#logout"
  
  resources :users, only: :create 
  resources :users, only: [:show], path: "/dashboard"  do
    resources :movies, only: [:index, :show] do 
      resources :viewing_party, only: [:new, :create]
    end
    get "/discover", to: "movies#discover", as: "movies_discover"
  end
end
