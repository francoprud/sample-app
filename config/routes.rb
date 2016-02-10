Rails.application.routes.draw do
  root 'static_pages#home'

  # StaticPages endpoints
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'help' => 'static_pages#help'

  # User endpoints
  resources :users, except: [:new]
  get 'signup' => 'users#new'

  # Session endpoints
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # Account Activations endpoints
  resources :account_activations, only: [:edit]
end
