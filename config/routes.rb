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
  resources :accounts, except: [:show, :index]
  resources :addresses, only: [:edit, :update, :show]
  resources :users, only: [:show, :index] do
    resources :likes, only: [:index]
    collection do
      get 'draft'
      get 'exhibition'
      get 'exhibition_trading'
      get 'exhibition_completed'
      get 'bought'
      get 'bought_completed'
    end
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
    resources :evaluations, only: [:create, :index]
    collection do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'delivery_method', defaults: { format: 'json' }
      get 'price_range', defaults: { format: 'json' }
      get 'search'
    end
    resources :trading, only: [:show, :update] do
      member do
        patch 'cancel'
        patch 'relist'
      end
    end
    resources :messages, only: [:create, :destroy]
  end
  get  '*unmatched_route', to: 'application#render_404', format: false
end
