Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'register', to: "registrations#create"
  post 'login', to: "sessions#create"

  get 'account', to: "accounts#show"
  get 'findaccount', to: "accounts#find"

  get 'elements/:id', to: "elements#show"

  post 'boards', to: "boards#create"
  get 'boards/:id', to: "boards#show"
  patch 'boards/:id', to: "boards#update"
  post 'boards/:id', to: "boards#add_owner"
  delete 'boards/:id', to: "boards#destroy"

end
