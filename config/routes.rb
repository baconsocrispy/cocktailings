Rails.application.routes.draw do
  resources :cabinets do 
    post :new, on: :member
  end
  resources :ingredients

  resources :recipes do
    post :favorite, on: :member
    get :favorites, on: :collection
  end

  # authentication routes
  devise_for :users, controllers: { sessions: 'users/sessions', 
                                    registrations: 'users/registrations',
                                    passwords: 'users/passwords'}
  devise_scope :user do 
    #reroutes users to sign-in after sign-out
    get "users", to: "users/sessions#new"
  end

  # Defines the root path route ("/")
  root 'recipes#index'
end
