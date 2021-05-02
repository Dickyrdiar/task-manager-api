class Api::V1::GroupInvitationsController < ApplicationController
    def show
        @group = Group.find(params[:group_id])
        @group_invtitations = GroupInvitation.where(:group_id => @group.id)
        render json: @group_invtitations
    end 

    def create 
        @group = Group.find(params[:group_id])
        @group_invtitation = @group.group_invtitation.create(group_invtitation_params.merge(sender: current_user))

        if @group_invtitation.save 
            if @group_invtitation.recipient != nil 
                @user = User.find(params[:user_id])
                GroupMailer.exsiting_user_invite(@group_invtitation).deliver
                @group_invtitation.recipient.group.push(@group_invtitation.group)
                render json: {
                    messages: 'user invite to group', 
                    is_messages: true, 
                    data: { group: @group_invtitation }
                }, status: :ok 
            else 
                GroupMailer.with(user: @user).welcome_email.devliver_now
                render json: @group_invtitation
            end 
            render json: { messages: 'Invitation failed' }, status: :failed
        end 
    end 

    def destroy 
        @group_invtitation.find(params[:id])
        @group_invtitation.destroy 
    end 

    private  

    def group_invtitation_params
        params.require(:group_invitation).permit(:group_id, :sender_id, :email)
    end 
end
