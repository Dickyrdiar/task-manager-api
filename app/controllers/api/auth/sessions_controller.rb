# require 'tiddle'
require 'jwt'
require 'httparty'
require 'json'

class Api::Auth::SessionsController < ApplicationController
    include HTTParty

    def create
        @user = User.where(email: params[:email]).first 
        
        if @user&.valid_password?(params[:password])
            session[:user_id] = @user.id
            token = JWT.encode({ user_id: @user.id }, Rails.application.secrets.jwt_secret, 'HS256')
            render json: { user: @user, token: token }, status: :ok
        else  
            render json: { error: 'invalid credential' }, status: :unauthorizes
        end 
    end 

    def google_oauth2 
        url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params["id_token"]}"
        response = HTTParty.get(url)
        @user = User.create_user_for_google(response.parsed_response)
        tokens = @user.create_new_auth_token
        @user.save 
    
        rense json: @user
    end 

    def destroy
        singed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)) 
        render json: {:success => false, auth_token: nil }.to_json, status: :ok
    end 
end
