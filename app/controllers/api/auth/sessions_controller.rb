require 'tiddle'

class Api::Auth::SessionsController < ApplicationController
    def create
        @user = User.where(email: params[:email]).first 
        
        if @user&.valid_password?(params[:password])
            token = Tiddle.create_and_return_token(@user, request)
            render json: { user: @user, token: token, sign_in: @user.last_sign_in_at }, status: :ok
        else  
            render json: { error: 'invalid credential' }, status: :unauthorizes
        end 
    end 

    def destroy  
    end 
end
