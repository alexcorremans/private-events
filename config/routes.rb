Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get '/about', to: 'pages#about'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/upcoming', to: 'events#index'
  get '/attended', to: 'events#index'
  resources :users, only: [:new, :create, :show]
  resources :events, except: [:edit, :update, :destroy]
  resources :invitations, only: [:index, :new, :create]
end
