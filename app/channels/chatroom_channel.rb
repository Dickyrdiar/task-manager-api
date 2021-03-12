class ChatRoom < ApplicationCable::Channel
    def subscribed
        if params[:room_id].present? 
            stream_from("ChatRoom-#{(params[:room_id])}")
        end  
    end  

    def speak(data)
        sender = get_sender(data)
        room_id  = data['room_id']
        message = data['message']

        raise 'No room_id!' if room_id.blank? 
        convo = get_convo(room_id) 
        raise 'No conversation found' if convo.blank? 
        raise 'No message!' if message.blank? 

        convo.users << sender unless convo.users.include?(sender)
        Message.create!(
            project: convo, 
            sender: sender, 
            text: message
        )
    end 

    def get_convo(room_code)
        Project.find_by(room_code: room_code)
    end 

    def get_sender
        User.find(guid: id) 
    end 
end 