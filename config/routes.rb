Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'registrations#new'

  resources :cats, only: [:index, :show, :edit, :update]

  get "/register", to: "registrations#new"
  post "/register", to: "registrations#create"
end
