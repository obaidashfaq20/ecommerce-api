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
end
