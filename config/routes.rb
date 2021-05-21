Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  devise_for :users, :controllers => { :omniauth_callbacks => "api/auth/omniauth_callbacks" }
  get '/notification/notify' => 'notification#notify'

  namespace :api do
    namespace :v1 do

      resources :groups do 
        resource :invitations
        resources :projects do
          resource :project_invitations
          resource :messages
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
