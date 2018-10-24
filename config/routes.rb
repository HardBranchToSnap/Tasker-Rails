Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks
  resources :projects do
    resources :messages
  end

  unauthenticated :user do
    root 'main#index'
  end

  authenticated :user do
    root 'tasks#index'
  end
end
