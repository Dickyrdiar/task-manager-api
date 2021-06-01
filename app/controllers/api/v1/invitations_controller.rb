class Api::V1::InvitationsController < ApplicationController
    def show
        @group = Group.find(params[:group_id])
        @invitations = Invitation.where(:group_id => @group.id)
        render json: @invitations
    end 
    
    def create
        @group = Group.find(params[:group_id])
        @invitation  = @group.invitations.create(invitation_params.merge(sender: current_user))
    
        if @invitation.save
            if @invitation.recipient != nil 
                @user = User.find(params[:user_id]) 
                InviteMailer.existing_user_invite(@invitation).deliver 
                @invitation.recipient.group.push(@invitation.group)
                render json: {
                    messages: 'user invited', 
                    is_messages: true, 
                    data: { invitation: @invitation }
                }, status: :ok
            else 
               InviteMailer.invite_email(@invitation).deliver_now 
               render json: {
                messages: 'user invited', 
                is_messages: true, 
                data: { invitation: @invitation }
            }, status: :ok
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
        params.require(:invitation).permit(:group_id, :email, :recipient_id) 
    end 
end
