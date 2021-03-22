class Api::V1::InvitationsController < ApplicationController
    def show
        # @invitations = Invitation.all 
        # render json: @invitations 

        @project = Project.find(params[:project_id])
        @invitations = Invitation.where(:project_id => @project.id)
        render json: @invitations
    end 

    def create
        @project = Project.find(params[:project_id])
        @invitation  = @project.invitations.create(invitation_params.merge(sender_id: current_user))
        # @invitation.sender_id  = current_user.id 

        if @invitation.save
            # if user already exist
            if @invitation.recipient != nil 
                # send notification email 
                InviteMailer.existing_user_invite(@invitation).deliver 
                # add user to project 
                @invitation.recipient.project.push(@invitation.project)
            else 
                Invitation.new_user_invite(@invitation, new_user_registration_path(:invite_token => @invitation.token)).deliver
            end  
        else 
            render json: { messages: 'invitation failed' }, status: :failed
        end  
    end 

    private 

    def invitation_params
        params.require(:invitation).permit(:project_id, :email) 
    end 
end
