class ProjectChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    if params[:project_id].present? 
      stream_from("chatroom-#{(params[:room_id])}")
    end 
  end

  def speak(data)
    sender = get_sender(data)
    room_id = data['room_id']
    message = data['message']

    raise 'No room_id' if room_id.blank? 
    convo = get_convo(room_id)
    raise 'No conversation found!' if convo.blank? 

    convo.users << sender unless convo.users.include?(sender)

    Message.create!(
      project: convo, 
      user:  sender, 
      content: message
    )
  end

  def get_convo(room_code)
    Project.find_by(room_conde: room_code)
  end 

  def get_sender
    User.find_by(guid: id)
  end 
end
