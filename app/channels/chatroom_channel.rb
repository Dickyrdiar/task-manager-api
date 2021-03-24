class ChatRoom < ApplicationCable::Channel
    def subscribed
        if params[:project_id].present? 
            stream_from("ChatRoom-#{(params[:project_id])}")
        end  
    end  

    def speak(data)
        sender = get_sender(data)
        project_id  = data['project_id']
        message = data['message']

        raise 'No room_id!' if project_id.blank? 
        convo = get_convo(project_id) 
        raise 'No conversation found' if convo.blank? 
        raise 'No message!' if message.blank? 

        convo.users << sender unless convo.users.include?(sender)
        Message.create!(
            project: convo, 
            sender: sender, 
            text: message
        )
    end 

    def get_convo(project_code)
        Project.find_by(project_code: project_code)
    end 

    def get_sender
        User.find(guid: id) 
    end 
end 