class ProjectChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    if params[:project_id].present? 
      stream_from("ProjectRoom-#{(params[:project_id])}")
    end 
  end

  def speak(data)
    sender = get_sender(data)
    project_id = data['project_id']
    message = data['message']

    raise 'No project_id' if project_id.blank? 
    convo = get_convo(project_id)
    raise 'No conversation found' if convo.blank? 
    raise 'No message!' if message.blank?

    convo.users << sender unless convo.users.include?(sender)

    Message.create!(
      conversation: convo, 
      sender: sender, 
      content: message
    )
  end 

  def get_convo
    Project.find_by(project_code: project_code)
  end 

  def get_sender
    User.find_by(guid: id) 
  end 

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def dirrect_message
  end
end
