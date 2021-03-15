Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :groups do 
        resources :projects do 
          resource :message, only: [:create, :destroy]
        end 
      end 

      post "/invitegroup" => "invite_group#create"
      post "/inviteproject" => "invite_project#create"
      mount ActionCable.server => '/cable'
    end  

    namespace :auth do
      resource :sessions
      resources :users
    end 
  end                                                                                                                                                                                       
end
