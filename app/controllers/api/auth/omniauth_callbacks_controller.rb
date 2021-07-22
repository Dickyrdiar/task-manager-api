require 'httparty'
require 'json'
class ::Api::Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include HTTParty 

  def google_oauth2 
    url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params["id_token"]}"
    response = HTTParty.get(url)
    @user = User.create_user_for_google(response.parsed_response)
    tokens = @user.create_new_auth_token
    @user.save 

    rense json: @user
  end 
end
