require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ForestLiana::Engine => '/forest'
  devise_for :users, :controllers => { :omniauth_callbacks => "api/auth/omniauth_callbacks" }
  get '/notification/notify' => 'notification#notify'

  namespace :api do
    namespace :v1 do

      # get '/groups', to: 'groups#index'
      resources :groups  do  
        resources :invitations

        resources :projects do
          resources :messages
          resources :todolists
        end 
      end     
      mount ActionCable.server => '/cable'
    end  

    namespace :auth do
      resources :sessions
      resources :users 
      resources :conversations
    end 
  end                                                                                                                                                                                       
end
