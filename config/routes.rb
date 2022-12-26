Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root :to => "restaurants#index"
  get 'restaurant/upvote/:id' => 'restaurants#upvote', as: 'restaurant_upvote'
  get 'dish/upvote/:id' => 'dishes#upvote', as: 'dish_upvote'
  get 'restaurants/list' => 'restaurants#list', as: 'restaurants_list'
  post 'dish/create/:id' => 'dishes#create', as: 'dish'
  post 'comment/create/:id' => 'comments#create', as: 'comment'
  post 'replies/:id/:commend_id' => 'replies#create', as: 'reply'
  resources :users
  resources :sessions, only: [:new, :create]
  resources :restaurants
  resources :comments
  resources :dishes
  resources :replies
  get 'sessions/logout' => 'sessions#logout'
end
