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
    member do 
      resources :chats, only: [:index]
    end
  end
  
  root to: "homes#top"
  get 'home/about' => 'homes#about'
end
