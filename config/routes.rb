Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :projects  
      resources :groups
    end  

    namespace :auth do
      mount ActionCable.server => '/cable'
      resource :sessions
      resources :users
    end 
  end                                                                                                                                                                                       
end
