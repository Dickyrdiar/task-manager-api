Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  devise_for :users, :controllers => { :omniauth_callbacks => "api/auth/omniauth_callbacks" }
  get '/notification/notify' => 'notification#notify'

  namespace :api do
    namespace :v1 do

      get '/groups', to: 'groups#index'
      resources :groups  do  
        resources :invitations

        get '/projects', to: 'projects#index'
        resources :projects do
          get '/messages', to: 'messages#inde'
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
