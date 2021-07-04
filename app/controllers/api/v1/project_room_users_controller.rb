class ProjectRoomUsersControler < ApplicationController
    before_action :set_project_room_user_params

    def create 
        @project_room_user = ProjectRoomUser.projects.where(user_id: current_user.id).first_or_create
        render :show, status: :ok 
    end 

    def destroy 
        @project_room_user = @prject.project_room_users.where(user_id: current_user.id).destroy 
        render json: { message: 'project has close' }
    end 

    private 

    def set_project_room_user_params
        @project = Project.find(params[:project_id])
    end 
end 