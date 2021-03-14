class Api::V1::InvitationsController < ApplicationController
    def create
       if @group.has_connected_with(current_user)
        
        self.resource = resource_class.invite!(params[resource_name])
    end 

    def edit 
        sign_out_send("current_#{resource_name}") if send("#{resource_name}_signed_in?")
        set_minimum_password_length
        resource.invitation_token = params[:invitation_token]
        redirect_to "http://localhost:3001/api/v1/invitations/accept?invitation_token=#{params[:invitation_token]}"
    end 

    def update
        super do |resource|
            if resource.errors.empty? 
                render json: { status: "Invitation Accepted!" }, status: 200 
            else 
                render json: resource.errors,  status: 401
            end 
        end  
    end 

    private  

    def configure_permitted_paramsters
        devise_parameter_sanitizer.permit(:accetp_invitation, key: [:first_name, :last_name]) 
    end 
end
