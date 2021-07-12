Rails.application.routes.draw do
  devise_for :users, :controllers => {
  :registrations => "users/registrations"
  }
  get 'dogs/index'

  get 'about' => 'homes#about'
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    collection do
      get :search
    end
  end

  get 'users/confirm' => 'users#confirm'
  patch 'users/out' => 'users#out'
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    collection do
      get :search
      end
    end


  resources :dogs, only: [:show,  :create, :destroy]

  root to: 'homes#top'
end
