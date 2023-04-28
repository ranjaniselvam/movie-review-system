Rails.application.routes.draw do
  get 'movies/new', to: 'movies#new', as: 'new_movie'
  get "/users/edit", to: "users#edit", as: "edit_user"
  patch "/users", to: "users#update", as: "update_user"
  devise_for :users
  resources :movies do
    resources :reviews do
      member do
        put "upvote", to: "reviews#upvote"
        put "downvote", to: "reviews#downvote"
    end
    end
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "movies#index"
  resources :users
  # get "welcome/index"
end
