Rails.application.routes.draw do

  get 'password_reset/new'
  get 'password_reset/edit'
  root 'static_pages#home'
  get 'home',   to: 'static_pages#home'
  get 'help',   to: 'static_pages#help'
  get 'about',  to: 'static_pages#about'
  get 'signup', to: 'users#new'
  get 'login',  to: "sessions#new"
  post 'login', to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users do
    member do
      get :schools, :entered_schools, :following, :followers
    end
  end
  resources :schools do
    member do
      get :belonging_students
    end
  end
  resources :user_relationships do
    member do
      get :following, :followers
    end
  end
  resources :retweets, only: [:create, :destroy]
  resources :school_chats, only: [:create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :school_relationships, only: [:create, :destroy]
  resources :user_relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
