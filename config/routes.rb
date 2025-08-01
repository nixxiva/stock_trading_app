Rails.application.routes.draw do
  
  devise_for :users
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root to: "trader/stocks#index"

  namespace :admin do
    root to: 'dashboard#index', as: :root

    resources :dashboard, only: [:index]
    resources :users, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      collection do
        get :pending_approvals
      end
      member do
        patch :approve
      end
    end
    resources :transactions, only: [:index]
  end

  namespace :trader do
    resources :users, only: [:show, :index] do
      resources :stocks, only: [:index]
      resources :transactions, only: [:index, :new, :create]
    end
  end

  match "*unmatched", to: "errors#not_found", via: :all

  match "*unmatched", to: "errors#not_found", via: :all
end
