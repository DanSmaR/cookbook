Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :recipe_types, only: %i[new create index show]
  resources :recipes, only: %i[new create edit update show] do
    resources :lists, only: %i[] do
      collection do
        get 'pick'
        post 'add'
      end
    end
  end
end
