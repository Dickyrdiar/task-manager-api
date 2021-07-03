class RoomChannel < ApplicationCable::Channel
    def subscribed
        if params[:conversation_id].present? 
            stream_from(params[:conversation_id])
        end 
    end 

    def speak(data)
        sender = get_sender(data)
        conversation_id = data['conversation_id']
        direct_message = data['direct_message']

        raise 'No conversation_id' if conversation_id.blank? 
        convo = get_convo(conversation_id)
        raise 'no conversation found!' if convo.blank? 
        raise 'no message!' if direct_message.blank? 

        convo.users << sender unless convo.users.include?(sender)

        DirectMessage.create!(
            conversatio: convo, 
            sender: sender, 
            direct_message: direct_message
        )
    end 

    def get_convo(room_code)
        Conversation.find_by(room_code: room_code)
    end 

    def get_sender
        User.find_by(guid: id)
    end 
end 