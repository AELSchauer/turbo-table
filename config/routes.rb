Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "courses#index"

  resources :courses, only: [:index] do
    collection do
      get "filter/:attr", to: "courses/filter#show", as: "filter"
      get "sort", to: "courses/sort#show"
    end
  end
end
