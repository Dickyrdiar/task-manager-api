Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :projects  
      resources :usersinvitations, only: %i[edit update create]
      resources :groups
    end  

    namespace :auth do
      mount ActionCable.server => '/cable'
      resources :users 
      resources :sessions, only: %i[create destroy]
    end 
  end                                                                                                                                                                                       
end
