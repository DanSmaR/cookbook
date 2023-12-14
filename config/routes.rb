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
    end
  end
end
