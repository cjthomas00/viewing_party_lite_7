Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  get "/register", to: "users#new"
  get "/login", to: "users#login_form"
  post '/login', to: 'users#login_user'
  delete '/login', to: 'users#logout_user'
  get "/dashboard", to: "users#show"
  get "movies/:id/viewing_party/new", to: "viewing_party#new"

  resources :users, only: [:show, :create]  do
    resources :movies, only: [:index, :show] do 
      resources :viewing_party, only: [:new, :create]
    end
    get "/discover", to: "movies#discover", as: "movies_discover"
  end

  resources :movies, only: [:index, :show]
  get "/discover", to: "movies#discover", as: "movies_discover"

end
