require 'jwt'

class Api::Admin::SessionsController < BaseController 
    def create
        @admin = Admin.where(username: params[:username]).first 
        
        if @admin&.valid_password?(params[:password])
            session[:admin_id] = @admin.id
            token = JWt.encode({ admin_id: @admin.id }, Rails.application.secrets.jwt_secret, 'HS256')
            render json: { amdin: @admin, token: token }, status: :ok 
        else 
            render json: { error: 'invalid login admin' }, status: :unauthorized
        end 
    end 

    def destroy 
    end 
end 