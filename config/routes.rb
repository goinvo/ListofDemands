Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :local_demands do
    member do
      post :demand_it
    end
  end

  resource :profile, only: [:show, :edit, :update], controller: :profile
  resource :search, only: [:show], controller: :search
  resource :area, controller: :area
  
  root to: "welcome#index"
end
