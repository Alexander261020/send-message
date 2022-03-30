Rails.application.routes.draw do
  root "messages#index"
  resources :messages, only: [:create]
  get "/messages/input/", to: "messages#input"
end
