Rails.application.routes.draw do
  root 'events#index'
  resources :users
  resources :sessions, only: %i[new create destroy]

  resources :events do
    resources :event_attendances, only: %i[create]
  end

  resources :event_attendances, only: %i[destroy]
end
