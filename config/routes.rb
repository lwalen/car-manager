CarManager::Application.routes.draw do
  
  root to: 'pages#index'
  get 'pages/index'

  resources :users do
    member do
      get 'register', to: :new
      get 'settings', to: :edit
    end
  end

  controller :sessions do
    get 'signin', to: :new
    post 'signin', to: :create
    get 'signout', to: :destroy
  end

  resources :cars do
    member do
      get 'more_records'
      get 'import'
      patch 'upload'
    end

    resources :gas_records do
      member do
        post 'toggle_stats'
      end
    end

    resources :service_records
  end

  resources :service_types

end
