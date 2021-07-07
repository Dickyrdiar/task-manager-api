class Api::NotificationController < ApplicationController
    def index
        @notifications = Notification.where(user: current_user)
            .unviewd.lastes
        
        render :show, status: :ok
    end 

    def update
        @notification = Notification.find(params[:id])
        message = @notification.update(notification_params) ? "viewed notification" : "there was an error"
        
        render json: { message: 'message' }
    end
    
    private 

    def notification_params
        params.require(:notification).permit(:viewed) 
    end 
end 