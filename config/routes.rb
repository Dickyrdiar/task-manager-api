Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :groups do 
        resource :groupinvitations 
        resources :projects do
          resource :invitations
          resource :messages
        end 
      end     
      mount ActionCable.server => '/cable'
    end  

    namespace :auth do
      resource :sessions
      resource :users
      match '/auth/:provider/callback', to: 'sessions#callback', :via => [:get, :post]
    end 
  end                                                                                                                                                                                       
end
