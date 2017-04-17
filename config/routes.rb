Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'register', to: "registrations#create"
  get 'account', to: "accounts#show"
  resources :elements

end
