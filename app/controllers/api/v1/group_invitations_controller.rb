class Api::V1::GroupInvitationsController < ApplicationController
    def index
        @groupInvitations = Groupinvitation.all 
        render json: @groupinvitations
    end 

    def create
          
    end 
end
