Rails.application.routes.draw do
  # adminログイン
  devise_for :admins, controllers: {
  sessions: 'admins/sessions'
  }
  # userログインサインアップ
  devise_for :users, :controllers => {
  :registrations => "users/registrations"
  }
  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # 管理者関連
  namespace :admin do
  patch 'users/out' => 'users#out'
  resources :posts, only: [:index, :show, :destroy, :update] do
  resource :reports, only: [:destroy]
  end
  resources :users, only: [:show, :update ]
  end

   # user関連
  scope module: :user do
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
      resource :reports, only: [:create]
      collection do
        get :search
        end
      end

    resources :dogs, only: [:show,  :create, :destroy]
  end

  # top関連
  get 'about' => 'homes#about'
  root to: 'homes#top'
end
