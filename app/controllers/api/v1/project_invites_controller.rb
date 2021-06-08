class Api::V1::ProjectInvitesController < ApplicationController
    def show
        @project = Project.find(params[:project_id])
        @project_invites = ProjectInvite.where(:project_id => @project.id) 
        # render json: @project_invites
    end 

    def create 
        @project = Project.find(params[:project_id])
        @project_invite = @project.project_invites.create(project_invite_params.merge(sender: current_user))

        if @project_invite.save
            if @project_invite.recipient != nil  
                ProjectMailer.existing_user_invite(@project_invite).deliver 
                @project_invite.recipient.project_invite.push(@project_invite.project)
                
                render :show, status: :ok
            else 
                ProjectMailer.invite_email(@project_invite, new_user_registration_path(:invite_token => @project_invite.token)).deliver_now
                render :show, status: :ok
            end  
        else 
            render json: {
                messages: 'invalid failed'
            }, status: :unproccessable_entity
        end 
    end 

    private 

    def project_invite_params
        params.permit(:project_id, :email, :recipient_id)
    end 
end
