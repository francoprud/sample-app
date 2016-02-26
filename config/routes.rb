Rails.application.routes.draw do
  root 'static_pages#home'

  # StaticPages endpoints
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'help'    => 'static_pages#help'

  # User endpoints
  resources :users, except: [:new] do
    member do
      get :following, :followers
    end
  end

  get 'signup' => 'users#new'

  # Micropost endpoints
  resources :microposts, only: [:create, :destroy]

  # Session endpoints
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # Account Activation endpoints
  resources :account_activations, only: [:edit]

  # Password Reset endpoints
  resources :password_resets, only: [:new, :create, :edit, :update]

  # Relationship endpoints
  resources :relationships, only: [:create, :destroy]
end
