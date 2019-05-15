Rails.application.routes.draw do
  get 'authorizations/index'

  get 'authorizations/create'

  resources :accounts do
    post 'fetch_transactions', on: :member
  end
  get '/accounts/:account_id/transactions', to: 'accounts#transactions', as: :account_transactions

  resources :authorizations, only: [:create, :index, :new] do
    post 'link', on: :member
    put 'refresh_accounts', on: :member
    put 'unauthorize', on: :member
  end

  root to: 'transactions#index'

  resources :transactions, only: [:index, :edit, :update, :show]

  resources :rules do
    post 'apply', on: :collection
  end

  resources :classifications do
    get 'transactions', on: :member
  end

  devise_for :users
  resources :users

  resources :reports, only: [:new, :create, :show]
end
