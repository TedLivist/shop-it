Rails.application.routes.draw do
  apipie
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api, defaults: { format: :json } do
    namespace :user do
        post '/sign_up', to: 'auth#sign_up'
        post '/verify_otp', to: 'auth#verify_otp'
        post '/send_otp', to: 'auth#send_otp'
        post '/sign_in', to: 'auth#sign_in'
    end

    namespace :brand do
      resources :products, only: [:create, :update, :destroy, :index]
      resources :order_items, only: [:index, :update]

      resources :metrics, only: [] do
        collection do
          get :sales_summary
          get :top_products
        end
      end
    end

    resources :products, only: [:index, :show]
    resources :categories, only: [:index]

    namespace :customer do
      resources :delivery_addresses, only: [:create, :update, :index]
      resources :orders, only: [:create]
    end
  end
end
