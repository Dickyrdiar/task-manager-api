require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins
  mount Sidekiq::Web => '/sidekiq'
  mount ForestLiana::Engine => '/forest'
  devise_for :users, :controllers => { :omniauth_callbacks => "api/auth/omniauth_callbacks" }
  get '/notification/notify' => 'notification#notify'

  namespace :api, defaults: { format: :json } do
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
      resources :sessions, only: %i[create destroy]
      resources :users 

      post '/google_oauth2', to: 'sessions#google_oauth2'
      delete '/sign_out' => 'sessions#destroy'
    end 

    namespace :admin do 
      resources :admins
      resources :sessions, only: %i[create destroy]
      resources :admin_groups do 
        resources :admin_projects
      end 
    end 
  end                                                                                                                                                                                       
end
