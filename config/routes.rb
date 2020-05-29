Rails.application.routes.draw do
  root 'tops#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tops, only: [:new]
  resources :accounts, except: [:show, :index]
  resources :users, only: [:show] do
    resources :likes, only: [:index]
  end
  resources :categories, only: [:index, :show] 
  resources :cards, except: [:show,:edit,:update] do
    member do
      get 'check'
      get 'buy'
    end
  end
  resources :items do
    resources :likes, only: [:create, :destroy]
    collection do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'draft'
      get 'exhibition'
      get 'exhibition_trading'
      get 'bought'
    end
  end

  resources :notifications, only: [:index]
end
