Rails.application.routes.draw do

  root 'chirps#index'

  resources :chirps do
    resources :comments, only: [:create]
    member do
      get "shares" # Form
      post "shares" => 'chirps#sender' # Sends it
    end
  end
  resources :users do
    resources :comments, only: [:create]
  end

  resources :comments, only: [] do
    resources :comments, only: [:create]
  end

  # resources :shares, only: [:new, :create]

  get "/login" => 'sessions#new', as: :login
  post "/login" => 'sessions#create'
  delete "/logout" => 'sessions#destroy', as: :logout
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
