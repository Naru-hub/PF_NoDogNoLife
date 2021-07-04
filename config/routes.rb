Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/show'
  get 'posts/new'
  get 'posts/edit'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'homes/top'
  get 'homes/about'
  devise_for :users
  get 'about' => 'homes#about'
  resources :users, only: [:index, :show, :edit, :update]
  get 'users/confirm' => 'users#confirm'
  patch 'users/out' => 'users#out'
  resources :posts
  get 'searches' => 'seaches#search'
  root to: 'homes#top'
end
