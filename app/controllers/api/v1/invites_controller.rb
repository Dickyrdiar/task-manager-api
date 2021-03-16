class Api::V1::InvitesController < ApplicationController
    def create
        @invite = Invite.new(invite_params)
        @invite.sender_id = current_user.id 

        if @invite.save 
            if @invite.recipient != nil  
                InviteMailer.existing_user_invite(@invite).deliver
                @invite.recipient.project.push(@invite.project)
            else 
                InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver
            end 
        else 
            render json: { message: @invite.errors.full_message }
        end 
    end 

    private 

    def invite_params 
        params.require(:invite).permit(:project_id, :email)
    end 
end
