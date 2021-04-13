Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, controllers: { omniauth_callbacks: 'api/auth/omniauth_callbacks' }
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
    end 
  end                                                                                                                                                                                       
end
