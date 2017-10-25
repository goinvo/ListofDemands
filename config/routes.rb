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
  
  root to: "welcome#index"
end
