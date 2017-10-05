Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'


  # namespace :admin do
    resources :trips do
      resources :activities, only: [:index, :show, :delete]
     end
   end
# end
