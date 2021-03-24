class MessageBroadcastJob < ApplicationJob
    queue_as :default 
    
    def perform(message)
        ActionCable.server.broadcast "chat_rooms_#{message.chat_room.id}_channel", message: 'MESSAGE HTML'
    end 

    private  

    def render_message(message)
        MessageController.render partial: 'messages/message', locals: {message: message}
    end 
end 