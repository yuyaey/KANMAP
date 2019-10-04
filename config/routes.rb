Rails.application.routes.draw do
  get 'abouts/index', to: 'abouts#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :kanzumes do
    resources :maps
  end
  resources :kanzume_icons
  resources :items
  resources :item_icons
  resources :maps  
  root to: 'maps#index'

  resources :testsessions, only: :create


end
