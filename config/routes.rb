Rails.application.routes.draw do
  resources :users
  resources :events
  resources :invitations, only: %i[create destroy]
  root 'events#index'
  get '/sessions/new', to: 'sessions#new'
  post '/users/log_in', to: 'users#log_in'
  # post '/users/show', to: 'users#show'
   post '/users/sign_out', to: 'users#sign_out'
end
