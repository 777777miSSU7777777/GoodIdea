Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root "projects#index"

  get '/contacts', to: 'static_pages#contacts'
  get '/about', to: 'static_pages#about'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/profile/user/edit/:id', to: 'users#edit', as: "edit_profile"
  post '/profile/user/edit/:id', to: 'users#update'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/projects', to: 'projects#index', as: "projects"
  get '/projects/new', to: 'projects#new', as: "new_projects"
  post '/projects/new', to: 'projects#create'
  get '/projects/:id', to: 'projects#show', as: "project"
  get '/projects/edit/:id', to: 'projects#edit', as: "edit_project"
  post '/projects/edit/:id', to: 'projects#update'
  delete '/projects/:id', to: "projects#delete"

  post '/projects/:post_id', to: 'donations#create'

  resources :posts do 
    resources :donations
  end
end
