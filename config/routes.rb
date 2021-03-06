Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :user_profiles, only: [:edit, :create, :update, :destroy]

  get    'users/search'       => 'users#search',       as: :users_search
  post   'users/:id/friend'   => 'users#friend',       as: :friend
  delete 'users/:id/unfriend' => 'users#unfriend',     as: :unfriend
  get    'users/:id/profile'  => 'user_profiles#edit', as: :users_edit_profile
  get    'users/:id'          => 'users#show',         as: :user

  get 'movies/search'         => 'movies#search',      as: :movies_search
  get 'movies/:id'            => 'movies#show',        as: :movie

  resources :ratings
  resources :recommendations

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
