Rails.application.routes.draw do
  
  root to: 'homes#index'
  resources :homes,only: [:index]
  resources :items

  resources :items do
    resources :comments, only: [:create,:destroy],module: 'items'
  end
  
  resources :items do
      resource :likes, only: [:create,:destroy],module: 'items'
    end


  resources :items do
    collection do
      resources :searches, only: [:index],module: 'items'
    end
  end

  devise_for :users
  
  resources :users
  # get 'users/my_page' => 'users#show'
  # get 'users/quit' => "users#quit"
  patch 'users/withdraw' => 'users#withdraw'
  # resources :users, only: [:edit, :update]

  # いらないかも↓
  # resources :users do
  #   resources :comments, only: [:create,:destroy],module: 'users'
  # end

  resources :users do
    resources :relationships, only: [:create,:destroy],module: 'users'
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  get "/admin" => "admin/homes#index"

  devise_for :admin, skip: [:registrations, :passwords] ,controllers:{
    sessions: "admin/sessions"
  }


  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end

  namespace :admin do
    resources :posts, only: [:show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
