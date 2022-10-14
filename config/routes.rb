Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do 
    #reroutes users to sign-in after sign-out
    get "users", to: "devise/sessions#new"
  end
  resources :portions
  resources :ingredients
  resources :recipes do 
    resources :steps
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'recipes#index'
end
