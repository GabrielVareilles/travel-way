Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'


  # namespace :admin do
    resources :trips do
      resources :activities, only: [:index, :show, :delete]
     end

     get '/setplaces', to: 'pages#setplaces'
     post '/setactivities', to: 'pages#setactivities'
   end
# end
