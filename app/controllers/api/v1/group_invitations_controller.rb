class Api::V1::GroupInvitationsController < ApplicationController
    def index
        @groupinvitations = Groupinvitation.all 
        render json: @groupinvitations
    end 

    def create
        @groupinvitation = Groupinvitation.new(groupinvitation_params.merge(user: current_user))

        if @groupinvitation.save
            if @groupinvitation.recipient != nil 
                @user = User.find(params[:user_id])
                GroupMailer.existing_user_invite(@groupinvitation).deliver
                @groupinvitation.recipient.group.push(@groupinvitation.group)
                render json: @groupinvitation, status: :ok
            else 
                GroupMailer.with(user: @user).welcome_email.deliver
                render json: @groupinvitation 
            end 
        else 
            rendr json: { message: 'invite failed ' }, status: :failed
        end 
    end 

    private  

    def groupinvitation_params
        params.require(:groupinvitation).permit(:group_id, :sender_id, :email, :username)
    end 
end
