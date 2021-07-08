Rails.application.routes.draw do

  get 'dogs/index'
  devise_for :users
  get 'about' => 'homes#about'
  resources :users, only: [:index, :show, :edit, :update]
  get 'users/confirm' => 'users#confirm'
  patch 'users/out' => 'users#out'
  resources :posts
  resources :dogs, only: [:show,  :create, :destroy]
  get 'searches' => 'seaches#search'
  root to: 'homes#top'
end
