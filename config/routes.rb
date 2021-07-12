Rails.application.routes.draw do
  devise_for :users, :controllers => {
  :registrations => "users/registrations"
  }
  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  get 'about' => 'homes#about'
  
  get 'users/confirm' => 'users#confirm', as: 'confirm'
  patch 'users/out' => 'users#out', as: 'out'
  
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    collection do
      get :search
    end
  end

 
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
