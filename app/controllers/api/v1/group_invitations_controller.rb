class Api::V1::GroupInvitationsController < ApplicationController
    def show
        @group = Group.find(params[:group_id])
        @group_invitations = GroupInvitation.where(:group_id => @group.id)
        render json: @group_invitations
    end 

    def create 
        @group = Group.find(params[:group_id])
        @group_invitation = @group.group_invitations.create(group_invitation_params.merge(sender: current_user))

        if @group_invtitation.save
            if @group_invtitation.recicipient != nil 
                @user = User.find(params[:user_id])
                GroupMailer.existing_user_invite(@group_invitation).deliver
                @group_invitation.recipient.group.push(@group_invitation.group_members)
                
                render json: @group_invitation, status: :ok
            else  
                GroupMailer.with(user: @user).welcome_email.deliver_now 
                render json: @group_invitation
            end 
        else 
            render json: { messages: 'Invitation failed' }, status: :failed 
        end 
    end 

    private  

    def group_invitation_params
        params.permit(:group_id, :sender_id, :email)
    end 
end
