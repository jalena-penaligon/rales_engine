Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/most_items', to: 'most_items#index'
        get '/revenue', to: 'revenue#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/random', to: 'random#show'
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/', to: 'merchants#index'
        get '/:id', to: 'merchants#show'
      end

      scope :merchants do
        get '/:id/items', to: 'merchants/items#index'
        get '/:id/invoices', to: 'merchants/invoices#index'
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      scope :customers do
        get '/:id/invoices', to: 'customers/invoices#index'
        get '/:id/transactions', to: 'customers/transactions#index'
      end

      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
