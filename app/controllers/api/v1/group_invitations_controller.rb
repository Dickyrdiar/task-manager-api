class Api::V1::GroupInvitationsController < ApplicationController
    def show
        @group = Group.find(params[:group_id])
        invite  = GroupMember.where(:group_id => @group.id)
        render json: @group_invitations
    end 

    def create 
        @group = Group.find(params[:group_id])
        invite = GroupMember.new(group_invitation_params.merge(user_id: current_user, group_id: @group.id))

        if invite.save
            if invite.recipient_id != nil 
                @user = User.find(params[:user_id])
                GroupMailer.exsiting_user.project.push(@group.group_members).deliver
                invite.recipient.group.push(@group.group_members)
                render json: {
                    messages: 'user invited', 
                    is_messgaes: true, 
                    data: { invitation: @group },
                }, status: :ok
            else
                GroupMailer.with(user: @user).welcome_email.deliver_now 
                render json: @group
            end 
        else 
            render json: { messages: 'Invitation failed' }, status: :failed 
        end  
    end 

    private  

    def group_invitation_params
        params.permit(:email)
    end 
end
