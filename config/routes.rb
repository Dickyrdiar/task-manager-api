Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :projects  
      resources :usersinvitations, only: %i[edit update create]
    end  

    namespace :auth do
      resources :users 
      resources :sessions, only: %i[create destroy]
    end 
  end                                                                                                                                                                                       
end
