class Api::V1::ProjectInvitationsController < ApplicationController
    def show
        @project = Project.find(params[:project_id])
        @project_invitations = ProjectInvitation.where(:project_id => @project.id)
        render json: @project_invitations 
    end 

    def create  
        @project = Project.find_by(params[:project_id])
        invite = ProjectMember.new(user_id: params[:user_id], project_id: params[:project_id].merge(sender: current_user))

        if invite.save 
            if invite != nil
                @user = User.find(params[:user_id])
                ProjectMailer.exsiting_user_invite 
            else 
            end 
        else 
        end 
    end 
end
