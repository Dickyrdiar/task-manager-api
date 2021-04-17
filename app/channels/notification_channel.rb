class NotificationChannel < ApplicationCable::Channel 
    def subscribed
        sream_from "notifications:#{current_user.id}"
    end 

    def unsubscribed 
        stop_all_stream 
    end 
end 