class NotificationsJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast "notifications:#{notification.receiver_id}", html: html
  end
end
