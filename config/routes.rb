Rails.application.routes.draw do
  root "messages#index"
  resources :messages, only: [:create]
  post 'messages/send_message', to: 'messages#send_message', as: 'send_message'
end
