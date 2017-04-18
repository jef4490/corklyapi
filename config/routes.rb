Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'register', to: "registrations#create"
  get 'account', to: "accounts#show"
  post 'boards', to: "boards#create"
  get 'elements/:id', to: "elements#show"
  post 'login', to: "sessions#create"
  get 'boards/:id', to: "boards#show"

end
