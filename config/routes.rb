Rails.application.routes.draw do
  root to: 'homes#index'
  resources :homes,only: [:index]

  devise_for :users

  resources :items do
    collection do
      resources :likes, only: [:create,:destroy],module: 'items'
    end
  end

  resources :items do
    collection do
      resources :searches, only: [:index],module: 'items'
    end
  end

  resources :users do
    resources :comments, only: [:create,:destroy],module: 'users'
  end

  resources :users do
    resources :relationships, only: [:create,:destroy],module: 'users'
  end


  devise_for :admins

  get "/admin" => "admin/homes#index"

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end

  namespace :admin do
    resources :posts, only: [:show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
