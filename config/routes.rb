Rails.application.routes.draw do
  root "static_pages#index"
  get '/contacts', to: 'static_pages#contacts'
  get '/about', to: 'static_pages#about'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
end
