class DirectMessageJob < ApplicationJob
  queue_as :default

  def perform(direct_message)
    ActionCable.server.broadcast "user_#{direct_message.user}_channel", direct_message: 'MESSAGE HTML'
  end

  private 

  def render_direct_message(direct_message)
    DirectMessagesController.render partial: 'directmessage/directmessage', locals: {direct_message: direct_message}
  end 
end
