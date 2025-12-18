Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'home/index'

  resources :members do
    get :invite, on: :collection
  end
  
  resources :tenants do
    get :my, on: :collection
  end

  resources :users, only: [:index, :show] do
    member do
      patch :resend_invitation
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
