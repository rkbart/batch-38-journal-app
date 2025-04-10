Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    resources :tasks
  end

  authenticated :user do
    root "categories#index", as: :authenticated_root
  end

  devise_scope :user do
    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end
end