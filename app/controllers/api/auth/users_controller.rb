class Api::Auth::UsersController < ApplicationController
    before_action :authorize_request, except: [:index, :create, :update, :destroy]

    def index
        @users = User.all  
    end 

    def new
        @token = params[:invite_token] 
    end 

    def show
        render json: @users, status: :ok 
    end 

    def create
        @user = User.new(user_params)
        @user.role = User::ROLE[:owner]
        @token = params[:invite_token]

        if @token != nil 
            group = Inivitation.find_by_token(@token).group 
            @user.group.push(group) 
            @user.role = User::ROLE[:members]

            render json: @user, status: :ok 
        elsif @user.save
            render :show, status: :created
        else
            render json: @user.errors, status: :unproccessable_entity 
        end 
    end 

    def update 
        @user = User.find(params[:id])

        if @user.update(user_params)
            render :show, status: :ok
        else  
            render json: @user.errors, status: :unproccessable_entity
        end 
    end 

    def destroy
        @user = User.find(params[:id])
        @user.destroy 
        render json: {
            messages: 'user destroy success'
        }
    end 

    private  

    def set_user 
        @user = User.find(params[:id])
    end 

    def user_params
        params.permit(:email, :password, :password_confirmation, :username)
    end 
end
