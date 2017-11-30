Rails.application.routes.draw do
  root to: 'transactions#index'

  resources :transactions, only: [:index, :edit, :update]

  resources :rules, only: [:index, :new, :create, :update] do
    post 'apply', on: :collection
  end

  resources :classifications, except: :destroy

  devise_for :users
  resources :users
end
