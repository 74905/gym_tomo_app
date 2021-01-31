Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#new_gesut"
    post "users/guest2_sign_in", to: "users/sessions#new_gesut2"
  end
    
  resources :users, only: [:show, :edit, :update] do
    member do 
       get :following, :followers
    end
  end
  resource :relationships, only: [:create, :destroy]
  resources :rooms, except: [:destroy] do
  resources :chats, only: [:index, :destroy]
   get :searchs, on: :collection
   get :participants, on: :member
  end
  mount ActionCable.server => '/cable'
  root to: "homes#top"
  get 'home/about' => 'homes#about'
end
