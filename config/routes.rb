Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :tasks
  end
  
  get "tasks", to: "tasks#index", as: "tasks"

  authenticated :user do
    root "categories#index", as: :authenticated_root
  end

  devise_scope :user do
    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end
end