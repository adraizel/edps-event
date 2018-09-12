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

  # resources :mailsender, only: [:index] do
  #   post :check, on: :collection
  #   post :send, on: :collection
  #   get :result, on: :collection
  # end

  get '/mailsender', to: "mailsender#create", as: 'mailsender_index'
  post '/mailsender/check', to: "mailsender#check", as: 'mailsender_check'
  post '/mailsender/mailsend', to: "mailsender#mailsend", as: 'mailsender_mailsend'

  namespace :admin do
    root :to => "pages#index"
    resources :users
    resources :events
  end
end
