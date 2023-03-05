Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'pages#home'
  # root "articles#index"
  resources :articles
  resources :categories, except: %i[:destroy]
  resources :users, except: [:new]

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
