Rails.application.routes.draw do
  resources :blog_elements
  resources :posts, :path => 'blog', only: [:index, :show]
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
  resources :users
  root 'home#index'
  namespace :authors do
    resources :posts, :path => 'blog'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
