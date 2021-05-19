class Api::V1::ProjectInvitationsController < ApplicationController
    def show
        @project = Project.find(params[:project_id])
        @project_invitations = ProjectInvitation.where(:project_id => @project.id)
        render json: @project_invitations 
    end 

    def create  
        @project = Project.find(params[:project_id])
        invite = ProjectMember.new(project_invitations_params.merge(sender: current_user, project_id: @project.id)) 

        if invite.save
            if invite.recipient != nil 
                ProjectMailer.existing_user_invite(@project).deliver_now 
                invite.recipient.group.push(@project)
                render json: {
                    messages: 'user invited', 
                    is_messages: true, 
                    data: { invitations: @project }
                }, status: :ok 
            else  
                ProjectMailer.with(user: @user).welcome_email.deliver_now 
                render json: @project, status: :ok 
            end 
        else
            render json: { messages: 'invitation failed' }, status: :failed  
        end 
    end 

    def destroy  
        @user = User.find(params[:recipient_id])
        @user.destroy  

        render json: { messgaes: 'user has been remove' }, status: :ok 
    end 

    private  

    def project_invitations_params
        params.permit(:email)
    end 
end
