class Api::V1::GroupInvitationsController < ApplicationController
    def show
        @group = Group.find(params[:group_id])
        invite  = GroupMember.where(:group_id => @group.id)
        render json: @group_invitations
    end 

    def create 
        @group = Group.find(params[:group_id])
        invite = GroupMember.new(group_invitation_params.merge(sender: current_user, group_id: @group.id))
        # GroupMember.sender_id = current_user.id

        if invite.save
            if invite.recipient != nil 
                # @user = User.find(params[:user_id])
                GroupMailer.existing_user_invite(@group).deliver
                invite.recipient.group.push(@group)
                render json: {
                    messages: 'user invited', 
                    is_messgaes: true, 
                    data: { invitation: @group_members },
                }, status: :ok
            else
                GroupMailer.with(user: @user).welcome_email.deliver_now 
                render json: @group_members
            end 
        else 
            render json: { messages: 'Invitation failed' }, status: :failed 
        end  
    end 

    def destroy
        @user = User.find(params[:id])
        GroupMember.destroy 
    end 

    private  

    def group_invitation_params
        params.permit(:email, :project_id, :recipient_id)
    end 
end
