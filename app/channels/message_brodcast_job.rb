class MessageBroadcastJob < ApplicationJob 
    queue_as :default 

    def perform(message)
        payload = { 
            room_id: message.project.id, 
            text: message.text, 
            sender: message.sender, 
            participants: message.project.users.collect(&:id)
        }
        ActionCable.server.broadcast(build_room_id(message.project.id), payload)
    end 

    def build_room_id(id)
        "ChatRoom-#{id}"
    end 
end 