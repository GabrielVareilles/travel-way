Rails.application.routes.draw do
  root to: 'pages#home'
  resources :trips do
    resources :activities, only: [:index, :show, :delete]
    end
end
