Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :carts
  resources :products
  resources :orders, only: [:index, :create, :show]
  resources :order_items, only: [:index]
  resources :cart_items
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'cart/products', to: 'carts#products', as: 'cart_products'
  post 'cart_item/add_to_cart/:product_id', to: 'cart_items#add_to_cart', as: 'add_to_cart'

  post 'create_payment_intent', to: 'payments#create_payment_intent', as: 'create_payment_intent'
  get 'orders/:id/order_items', to: 'order_items#order_items', as: 'current_order_items'

  post 'stripe_webhook', to: 'payments#stripe_webhook', as: 'stripe_webhook'
end
