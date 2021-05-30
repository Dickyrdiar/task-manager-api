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
               InviteMailer.with(invitation: @invitation).welcome_email.deliver_now 
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
    
    
    def destroy
        @invitation.find(params[:id])
        @invitation.destroy 
        render json: {
            messages: 'user has remove'
        }  
    end 
    
    private 
    
    def invitation_params
        params.require(:invitation).permit(:group_id, :email, :recipient_id) 
    end 
end
