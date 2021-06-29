class DirectMessageJob < ApplicationJob
  queue_as :default

  def perform(direct_message)
    payload = {
      room_id: direct_message.conversation.id, 
      text: direct_message.text,
      sender:direct_message.sender, 
      participants: direct_message.conversation.user.collect(&:id) 
    }
    ActionCable.server.broadcast(buld_room_id(direct_message.conversation.id), payload)
  end

  def build_room_id(id)
    "ChatRoom-#{id}"
  end 

  private 

  def render_direct_message(direct_message)
    DirectMessagesController.render partial: 'directmessage/directmessage', locals: {direct_message: direct_message}
  end 
end
