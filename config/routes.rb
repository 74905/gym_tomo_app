Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
