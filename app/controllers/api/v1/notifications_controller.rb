class Api::V1::NotificationsController < ApplicationController
    def notify
        Message.all.eahc do |msg|
        n = Rpush::Gcm::Notification.new 
            n.app = Rpush::Gcm::App.find_by_name("teamwotk_notif")
            n.registration_ids = [msg.token]
            
            n.notification = {
                body: 'this notification is here', 
                title: 'notif', 
                sound: 'default'
            }
            n.save! 
        end 

        Rpush.push 
        render json: { sent: true }, status: :ok
    end 
end
