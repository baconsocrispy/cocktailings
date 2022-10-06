Rails.application.routes.draw do
  resources :steps
  resources :portions
  resources :ingredients
  resources :recipes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "recipes#index"
end
