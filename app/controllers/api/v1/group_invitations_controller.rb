class Api::V1::GroupInvitationsController < ApplicationController
    def show
        @group = Group.find(params[:group_id])
        @group_invitations = GroupInvitation.where(:group_id => @group.id)
        render json: @group_invitations
    end 

    def create 
        @group = Group.find(params[:group_id])
        invite = GroupMember.new(group_invitation_params.merge(user_id: current_user))

        if invite.save
            if invite.recipient != nil 
                @user = User.find(params[:user_id])
                GroupMailer.exsiting_user.project.push(@group.group_members).deliver
                invite.recipient.group.push(invite)


    end 

    private  

    def group_invitation_params
        params.permit(:group_id, :sender_id, :email)
    end 
end
