Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  patch 'users/update_interests/:id', :to => 'users#update_interests'
  post 'users/create_article/:id', :to => 'users#create_article'
  post 'users/create_club/:id', :to => 'users#create_club'
  get 'clubs/filtered_index', :to => 'clubs#filtered_index'
  patch 'clubs/add_member/:id', :to => 'clubs#add_member'
  post 'clubs/create_article/:id', :to => 'clubs#create_article'
  post 'clubs/create_event/:id', :to => 'clubs#create_event'
  resources :users
  resources :clubs
end
