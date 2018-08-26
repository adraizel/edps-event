Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "pages#index"

  get :login, :to => "session#new"
  post :login, :to => "session#create"
  post :logout, :to => "session#destroy"

  resource :user, except: [:destroy] do
    resources :events, except: [:index, :show] do
      get :held, on: :collection
      get :detail, on: :member
    end
    get :activate, on: :member
  end

  resources :events, only: [:index, :show] do
    get :join, on: :member
    post :join, on: :member
    post :unjoin, on: :member
    get :joined, on: :collection
  end

  namespace :admin do
    root :to => "pages#index"
    resources :users
    resources :events
  end
end
