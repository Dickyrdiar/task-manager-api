require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins
  mount Sidekiq::Web => '/sidekiq'
  mount ForestLiana::Engine => '/forest'
  devise_for :users, :controllers => { :omniauth_callbacks => "api/auth/omniauth_callbacks" }
  get '/notification/notify' => 'notification#notify'

  namespace :api do
    namespace :v1 do

      # get '/groups', to: 'groups#index'
      resources :groups  do  
        resources :invitations
        resources :conversations do 
          resources :direct_messages
        end

        resources :projects do
          resources :project_room_users
          resources :messages
          resources :todolists

          post '/messages/:id/project_room_users/:id' => 'messages#create'
        end 
      end     
      mount ActionCable.server => '/cable'
    end  

    namespace :auth do
      resources :notifications
      resources :sessions
      resources :users 
    end 

    namespace :admin do 
      resources :admins
      resources :sessions
      
    end 
  end                                                                                                                                                                                       
end
