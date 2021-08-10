Rails.application.routes.draw do
  resources :blog_elements
  resources :posts
  devise_for :users
  resources :users
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
