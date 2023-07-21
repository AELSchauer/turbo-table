Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "courses#index"

  resources :courses, only: [:index] do
    collection { get :filter, to: "courses#filter" }
  end
end
