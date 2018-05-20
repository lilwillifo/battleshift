Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  get  "/register", to: "users#new"
  post '/users', to: "users#create"
  get  '/login', to: 'sessions#new', as: 'log_in'
  post '/login', to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy', as: 'log_out'
  get '/dashboard', to: "users#show"
  get '/activate/:id', to: 'users#update', as: 'activate'

  namespace :api do
    namespace :v1 do
      resources :games, only: [:create, :show] do
        post "/shots", to: "games/shots#create"
        post "/ships", to: "games/ships#create"
        #ship_1_payload

      end
    end
  end
end
