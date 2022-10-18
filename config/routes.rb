Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root :to => "restaurants#index"
  get 'restaurant/upvote/:id' => 'restaurants#upvote', as: 'restaurant_upvote'
  get 'restaurants/list' => 'restaurants#list', as: 'restaurants_list'
  resources :users
  resources :sessions, only: [:new, :create]
  resources :restaurants
  resources :dishes
  resources :comments
  get 'sessions/logout' => 'sessions#logout'
end
