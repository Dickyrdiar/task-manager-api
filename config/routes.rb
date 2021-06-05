Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  devise_for :users, :controllers => { :omniauth_callbacks => "api/auth/omniauth_callbacks" }
  get '/notification/notify' => 'notification#notify'

  namespace :api do
    namespace :v1 do

      get '/groups', to: 'groups#index'
      resources :groups  do 
        resource :invitations do 
          member do 
            get 'leave'
          end 
        end 

        get '/projects', to: 'projects#index'
        resources :projects do
          resource :project_invites
          get '/messages', to: 'messages#index'
          resource :messages
          get '/todolists', to: 'todolists#index'
          resource :todolists
        end 
      end     
      mount ActionCable.server => '/cable'
    end  

    namespace :auth do
      resource :sessions
      resource :users
    end 
  end                                                                                                                                                                                       
end
