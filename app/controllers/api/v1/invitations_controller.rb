class Api::V1::InvitationsController < ApplicationController
    def show
        @group = Group.find(params[:group_id])
        @invitations = Invitation.where(:group_id => @group.id)
        # render json: @invitations
    end 
    
    def create
        @group = Group.find(params[:group_id])
        @invitation  = @group.invitations.create(invitation_params.merge(sender: current_user))
    
        if @invitation.save
            if @invitation.recipient != nil 
                InviteMailer.existing_user_invite(@invitation).deliver 
                @invitation.recipient.group.push(@invitation.group)
                
                render :show, status: :ok
            else 
                InviteMailer.with(@invitation, new_user_registration_path(:invite_token => @invitation.token)).invite_email.deliver_now 
                render :show, status: :ok
            end  
        else 
            render json: { messages: 'invitation failed' }, status: :failed
        end  
    end 
    
    def leave
        @group = Group.find(params[:id])
        current_user.update_attribute(group_id: @group.id)
        
        render json: { message: 'you leave group' }
    end 
    
    private 
    
    def invitation_params
        params.permit(:group_id, :email, :recipient_id) 
    end 
end
