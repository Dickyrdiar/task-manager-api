Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do


      resources :groups do 
        resources :projects do
          resource :invitations
          # resource :members 
          resource :message, only: [:create, :destroy]
        end 
      end
      
      
      resource :invites
      mount ActionCable.server => '/cable'
    end  

    namespace :auth do
      resource :sessions
      resource :users
    end 
  end                                                                                                                                                                                       
end
