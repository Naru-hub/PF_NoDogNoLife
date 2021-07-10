Rails.application.routes.draw do
  devise_for :users, :controllers => {
  :registrations => "users/registrations"
  }
  get 'dogs/index'
  
  get 'about' => 'homes#about'
  resources :users, only: [:index, :show, :edit, :update]
  get 'users/confirm' => 'users#confirm'
  patch 'users/out' => 'users#out'
  resources :posts, shallow: true do
    collection do
      get :search
    end
  end  
  
  resources :dogs, only: [:show,  :create, :destroy]
 
  root to: 'homes#top'
end
