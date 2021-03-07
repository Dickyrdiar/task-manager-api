Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :projects  
      resources :groups
    end  

    namespace :auth do
      mount ActionCable.server => '/cable'
      post '/login', to: 'sessions#create'
      resources :users
    end 
  end                                                                                                                                                                                       
end
