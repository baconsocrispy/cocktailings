Rails.application.routes.draw do
  resources :cabinets
  resources :ingredients

  resources :recipes do
    post :favorite, on: :member
    get :favorites, on: :collection
  end

  # authentication routes
  devise_for :users
  devise_scope :user do 
    #reroutes users to sign-in after sign-out
    get "users", to: "devise/sessions#new"
  end

  # Defines the root path route ("/")
  root 'recipes#index'
end
