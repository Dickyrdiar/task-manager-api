class MessageBroadcastJob < ApplicationJob
    queue_as :default 
    
    def perform(message)
        ActionCable.server.broadcast "project_rooms_#{message.project}_channel", message: 'MESSAGE HTML'
    end 

    private  

    def render_message(message)
        MessageController.renderer.render(partial: 'messages/message', locals: {message: message})
    end 
end 