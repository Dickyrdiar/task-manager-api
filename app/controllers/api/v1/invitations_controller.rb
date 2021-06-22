class Api::V1::InvitationsController < ApplicationController
    def index
        @group = Group.find(params[:group_id])
        @invitations = Invitation.where(:group_id => @group.id)
    end 
    
    def create
        @group = Group.find(params[:group_id])
        @invitation  = Invitation.new
        @invitation.user = current_user
        @invitation.group = current_group
    
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
    
    def leave
        @group = Group.find(params[:id])
        current_user.update_attribute(group_id: @group.id)
        
        render json: { message: 'you leave group' }
    end 
    
    private 
    
    def invitation_params
        params.permit(:user_id, :group_id, :email, :recipient_id) 
    end 
end
