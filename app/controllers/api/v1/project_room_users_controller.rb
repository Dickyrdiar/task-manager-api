class Api::V1::ProjectRoomUsersController < ApplicationController
    before_action :set_project_room_user_params
    before_action :authorize_request, except: [:index, :create, :destroy]

    def index
        # @group = Project.find(params[:project_id])
        @project_room_users = ProjectRoomUser.all
    end 

    def create 
        @project_room_user = ProjectRoomUser.projects.where(user_id: current_user.id).first_or_create
        # @project_room_user.user = current_user
        render :show, status: :ok 
    end 

    def destroy 
        @project_room_user = @project.project_room_users.where(user_id: current_user.id).destroy 
        render json: { message: 'project has close' }
    end 

    private 

    def set_project_room_user_params
        @project = Project.find(params[:project_id])
    end 
end 