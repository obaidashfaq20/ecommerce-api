Rails.application.routes.draw do
  resources :carts
  resources :products
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
end
