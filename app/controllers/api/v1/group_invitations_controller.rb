class Api::V1::GroupInvitationsController < ApplicationController
    def show
        @group = Group.find(params[:group_id])
        @group_invitations = GroupInvitation.where(:group_id => @group.id)
        render json: @group_invitations
    end 

    def create 
        @group = Group.find(params[:group_id])
        @group_invitation = GroupInvitation.new(group_invitation_params.merge(sender: current_user))

        if @group_invitation.save 
            if @group_invitation.recipient != nil  
                @user = User.find(params[:user_id])
                GroupMailer.existing_user_invite(@group_invitation).deliver 
                @group_invitation.recipient.group.push(@group_invitation.group_members)
                render json: {
                    messages: 'user invited', 
                    is_messages: true, 
                    data: { group_invitation: @group_invitation }
                }, status: :ok 
            else
                GroupMailer.with(user: @user).welcome_email.deliver_now 
                render json: @group_invitation, status: :ok 
            end 
        else  
            render json: { messages: 'invitation failed' }, status: :failed 
        end 
    end 

    private  

    def group_invitation_params
        params.permit(:group_id, :sender_id, :email)
    end 
end
