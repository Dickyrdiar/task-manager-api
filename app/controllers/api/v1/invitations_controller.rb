class Api::V1::InvitationsController < ApplicationController
    def create
        @invitation  = Invitation.new(invitation_params)
        @invitation.sender_id  = current_user.id 

        if @invitation.save
            # if user already exist
            if @invitation.recipient != nil 
                # send notification email 
                InviteMailer.existing_user_invite(@invitation).deliver 
                # add user to project 
                @invitation.recipient.project.push(@invitation.project)
            else 
                Invitation.new_user_invite(@invitation, new_user_regristation_path(:invite_token => @invitation.token)).deliver
            end  
        else 
            render json: { messages: 'invitation failed' }, status: :failed
        end  
    end 
end
