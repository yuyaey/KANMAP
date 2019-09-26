Rails.application.routes.draw do
  get 'page/index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
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
