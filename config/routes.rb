Rails.application.routes.draw do

# デバイス関係
  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers:{
  sessions: "admin/sessions"
  }
  

# ユーザー側
  root to: 'homes#index'
  resources :homes,only: [:index]
  resources :items

  resources :items do
    resources :comments, only: [:create,:destroy],module: 'items'
    resource :likes, only: [:create,:destroy],module: 'items'
    collection do
    resources :searches, only: [:index],module: 'items'
    end
  end

  resources :users do
    # get 'users/my_page' => 'users#show'
    get 'confirm' => "users#confirm"
    patch 'withdraw' => 'users#withdraw'
  end
    
    # resources :users, only: [:edit, :update]
  
  # いらないかも↓
  # resources :users do
  #   resources :comments, only: [:create,:destroy],module: 'users'
  # end

  resources :users do
    resources :relationships, only: [:create,:destroy],module: 'users'
  end


# 管理者ルーティング
  namespace :admin do
    resources :comments, only: [:index, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:show, :destroy]
    root to: 'comments#index'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
