Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :recipe_types, only: %i[new create index show]
  resources :recipes, only: %i[new create edit update show destroy] do
    collection do
      get 'search'
    end
    resources :lists, only: %i[create] do
      collection do
        get 'pick'
        post 'add'
      end
      member do
        delete 'remove'
      end
    end
  end

  resources :lists, only: %i[index show destroy]

  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i[index]
    end
  end
end
