class RoomChannel < ApplicationCable::Channel
    def subscribed
        if params[:room_id].present? 
            stream_from(params[:room_id])
        end 
    end 

    def speak_data
        sender = get_sender(data)
        room_id = data['room_id']
        message = data['message'] 

        raise 'no room_id' if room_id.blank? 
        convo = get_convo(room_id)
        raise 'no conversation found!' if convo.blank?
        raise 'no message' if message.blank? 

        convo.users << sender unless convo.users.include?(sender)

        Message.create!(
            conversation: convo, 
            sender: sender, 
            content: message
        )
    end 
end 