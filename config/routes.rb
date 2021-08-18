Rails.application.routes.draw do
  resources :contacts, only: [:index, :create]
  resources :tags do
    collection do
      post '/update_post_tags', to: "tags#update_post_tags", as: 'update_post_tags'
    end
  end
  #resources :comments, only: [:create, :update]
  root 'home#index'
  get 'thank-you', to: 'home#thank_you', as: 'thank-you'
  get 'about', to: 'home#about', as: 'about'
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  resources :blog_elements
  resources :posts, :path => 'blog', only: [:index, :show] do
    resources :comments, only: [:create, :update]
  end
  resources :users

  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  namespace :authors do
    resources :posts, :path => 'blog'
    resources :tags
  end

  namespace :admin do
    resources :contacts
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
