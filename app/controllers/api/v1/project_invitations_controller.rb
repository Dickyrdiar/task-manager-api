class Api::V1::ProjectInvitationsController < ApplicationController
    def show
        @project = Project.find(params[:project_id])
        @project_invitations = ProjectInvitation.where(:project_id => @project.id)
        render json: @project_invitations 
    end 

    def create 
        @project = Project.find(params[:project_id])
        @project_invitation = @project.project_invitations.create(project_invitation_params.merge(sender: current_user))

        if @project_invitations.save 
            if @project_invitation.recipient != nil
                @user = User.find(params[:user_id])
                ProjectMailer.existing_user_invite(@project_invitation).deliver
                @project_invitation.recipient.project.push(@project.project_members)
                render json: @project, status: :ok 
            else 
                ProjectMailer.with(user: @user).welcome.email.deliver_now 
                render json: @project
            end 
        else 
            render json: { messages: 'invitation failed' }, status: :unproccessable_entity
        end 
    end
    
    private  

    def project_invitation_params 
        params.require(:project_invitation).permit(:project_id, :sender_id, :email)
    end 
end
