class Api::V1::ProjectInvitationsController < ApplicationController
    def show
        @project = Project.find(params[:project_id])
        @project_invitations = ProjectInvitation.where(:project_id => @project.id)
        render json: @project_invitations 
    end 

    def create  
        @project = Project.find_by(params[:project_id])
        invite_project = ProjectMember.new(project_invitations_params.merge(sender: current_user, project_id: @project.id))

        if invite_project.save 
            if invite_project.recipient_id != nil 
                @user = User.find(params[:user_id])
                ProjectMailer.existing_user.project.push(@project.project_members).deliver
                invite_project.recipient.project.push(@project.project_members)
                render json: {
                    messages: 'user invited to project', 
                    is_messages: true, 
                    data: { invitation: @project_members }
                }, status: :ok 
            else  
                ProjectMailer.with(user: @user).welcome_email.deliver_now
                render json: @project_members
            end 
        else  
            render json: { messages: 'Invitation failed' }, status: :failed 
        end 
    end 

    private  

    def project_invitations_params
        params.permit(:email)
    end 
end
