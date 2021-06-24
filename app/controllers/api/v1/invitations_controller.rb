class Api::V1::InvitationsController < ApplicationController
    def index
        @group = Group.find(params[:group_id])
        @invitations = Invitation.where(:group_id => @group.id)
    end 
    
    def create
        @group = Group.find(params[:group_id])
        @invitation = @group.invitations.create(invitation_params.merge(sender: current_user))
        @invitation.group_id = current_group
    
        if @invitation.save
            if @invitation.recipient != nil 
                InviteMailer.existing_user_invite(@invitation).deliver 
                @invitation.recipient.group.push(@invitation.group)
                render :show, status: :ok
            else 
                InviteMailer.user_invite(invitation: @invitation.email).deliver
                render :show, status: :ok
            end  
        else 
            render json: { messages: 'invitation failed' }, status: :failed
        end  
    end 
    
    def destroy
       @invitation = Invitation.find(params[:id])
       @invitation.destroy 

       render json: { messages: 'user has been delete' }
    end 
    
    private 
    
    def invitation_params
        params.permit(:user_id, :group_id, :email, :recipient_id) 
    end 
end
