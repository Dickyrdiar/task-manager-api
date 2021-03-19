class Api::V1::InvitationsController < ApplicationController

    def new 
    end 

    def create 
        @project = Project.find(params[:project_id])
        @invite = Invitation.new(params[:invite])
        @invite.project_id 

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

    private 

    def invite_params
        params.require(:invite).permit(:email, :project_id, :user_id) 
    end 
end
