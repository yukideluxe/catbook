Rails.application.routes.draw do
  get 'application/current_cat'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'cats#index'

  resources :cats, only: [:index, :show, :edit, :update, :destroy]

  # We will only be using new and create
  # SessionsController is not backed by a model
  # but will behave as a model-backed one (CRUD)
  # Login -> Create
  # Logout -> Destroy
  resources :sessions
  resources :registrations

  get 'register' => 'registrations#new'
  post 'register' => 'registrations#create'

  delete 'delete' => 'cats#destroy'

  get 'logout', to: 'sessions#destroy', as: 'logout'
end
