

class Api::Auth::SessionsController < ApplicationController
    def create
        @user = User.where(email: params[:email]).first 
        
        if @user.authenticate(params[:password])
            token = JsonWebToken.encode(user_id: @user.id)
            render json: { user: @user }, status: :ok
        else  
            render json: { error: 'invalid credential' }, status: :unauthorizes
        end 
    end 

    def destroy  
    end 
end
