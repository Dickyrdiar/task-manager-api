class Api::V1::GroupsController < ApplicationController
    before_action :authorize_request, except: [:index, :show, :create, :update, :destroy]

    def index
        @groups = Group.all 
        render json: @groups 
        # @groups = Group.where(:user_id => current_user.id) 
        # render json: @groups
    end 

    def show
       @group = Group.find(params[:id])

       render json: @group
    end 

    def create
        @group = Group.new(group_params.merge(user: current_user))
       
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
