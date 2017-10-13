Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'

  resources :search, controller: :search, only: :index
  resources :fetchreviews, controller: :fetchreviews, only: :index

  # namespace :admin do
    resources :trips do
      resources :activities, only: [:index, :show, :delete]
     end

     get '/setplaces', to: 'pages#setplaces'
     get '/setactivities', to: 'pages#setactivities'
     get '/testapi', to: "pages#testapi"
     get '/profile', to: "pages#profile"
   end
# end
