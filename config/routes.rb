Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resource :profile, only: [:show, :edit, :update], controller: :profile
  resource :search, only: [:show], controller: :search
  resource :area, controller: :area
  resource :me, controller: :me
  resource :supported_demands
  resources :demands
  resources :users, only: [:show], path: '/', param: :slug

  root to: "search#show"
end
