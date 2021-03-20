class Api::V1::InvitationsController < ApplicationController

    def show  
        @invitations = Invitation.all
        render json: @invitations 
    end 
    
    def new 
    end 

    def create 
        @project = Project.find(params[:project_id])
        @invitation = @project.invitations.create(invitation_params.merge(user: current_user))

        if @invite.save 
            render json: {
                messages: "successfuly invited #{params[:invite][:email]}",
                is_messages: true 
            }, status: :ok 
        else
            render json: {
                messages: "invited failed", 
                is_messages: false
            }, status: :failed 
        end 
    end 

    def destroy
    end 

    private 

    def invitation_params
        params.permit(:email, :project_id, :user_id) 
    end 
end
