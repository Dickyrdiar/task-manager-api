class Api::Auth::UsersController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @users = User.all
        render json: @users  
    end 

    def show
        render json: @users, status: :ok 
    end 

    def create
        @user = User.new(user_params)

        if @user.save 
            render json: {
                messages: 'user create', 
                is_messages: true, 
                data: { user: @user }
            }, status: :ok
        else 
            render json: {
                message: 'user failed', 
                is_messages: false, 
                data: {}
            }, status: :failed 
        end 
    end 

    def update 
        @user = User.find(params[:id])

        if @user.update(user_params)
            render json: {
                message: 'user update', 
                is_message: true, 
                data: { user: @user }
            }
        else  
            render json: {
                message: 'update failed', 
                is_message: false, 
                data: {}
            }
        end 
    end 

    private  

    def set_user 
        @user = User.find(params[:id])
    end 

    def user_params
        params.permit(:email, :password, :password_confirmation, :username, :first_name, :last_name)
    end 
end
