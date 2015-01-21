CarManager::Application.routes.draw do
  
  devise_for :users
  root to: 'pages#index'
  get 'pages/index'

  resources :cars do
    member do
      get 'more_records'
      get 'import'
      patch 'upload'
    end

    resources :gas_records, only: [:new, :create, :destroy] do
      member do
        post 'toggle_stats'
      end
    end

    resources :service_records, only: [:new, :create, :destroy]
  end
end
