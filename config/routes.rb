Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root "static_pages#index"

  get '/contacts', to: 'static_pages#contacts'
  get '/about', to: 'static_pages#about'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/projects/own', to: 'projects#own'
  get '/projects', to: 'projects#index'
  get '/projects/new', to: 'projects#new'
  post '/projects/new', to: 'projects#create'
  get '/projects/:id', to: 'projects#show'
  
  resources :users
  resources :posts do 
    resources :comments
  end
end
