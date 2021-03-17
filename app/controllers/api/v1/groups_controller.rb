class Api::V1::GroupsController < ApplicationController
    before_action :authorize_request, except: [:index, :create, :update, :destroy]

    def index
        @groups = Group.all 
        render json: @groups  
    end 

    def new
        @group = current_user.groups.build
    end 

    def create
        @group = Group.new(group_params.merge(user: current_user))
        # @group = current_user.groups.create(params[:group])
        
        if @group.save 
            render json: {
                messages: 'group create', 
                is_messages: true, 
                data: { group: @group }
            }, status: :ok 
        else 
            render json: {
                messages: 'group failed', 
                is_messages: false, 
                data: {}
            }, status: :failed 
        end 
    end 

    def update 
        @group = Group.find(params[:id])
        if @group.save(group_params)
            render json: {
                messages: 'update success', 
                is_message: true, 
                data: { group: @group }
            }, status: :ok 
        else
            render json: {
                messages: 'update failed', 
                is_messages: false, 
                data: {}
            }, status: :failed 
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
    end 

    def group_params
        params.require(:group).permit(:name, :desc, :user_id)
    end 
end
