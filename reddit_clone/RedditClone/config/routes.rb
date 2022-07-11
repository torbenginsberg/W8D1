Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show] do
    resources :subs, only: [:create, :update, :destroy]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:create, :update, :destroy] do
    resources :posts, except: [:index]
  end
end
