class Api::V1::GroupsController < ApplicationController
    before_action :authorize_request, except: [:index, :create, :show, :update, :destroy]
   
    def index
        @groups = Group.where(:user_id => current_user)
    end 

    def show
        @group = Group.find(params[:id])
    end 

    def create
        @group = Group.new(group_params)
        @group.user = current_user

        if @group.save 
            render :show, status: :ok
        else 
           render json: @group.errors, status: :unprocessable_entity
        end 
    end 

    def update 
        @group = Group.find(params[:id])
        if @group.save(group_params)
           render :show, status: :ok
        else
            render json: @group.erros, status: :unprocessable_entity
        end    
    end 

    def destroy 
        @group = Group.find(params[:id])
        @group.destroy 

        render json: { messages: 'group success delete' }
    end 

    private 

    def set_group 
        @group = Group.find(params[:id])
        # authorize
    end 

    def group_params
        params.require(:group).permit(:name, :desc, :image, :role, :owner)
    end 
end
