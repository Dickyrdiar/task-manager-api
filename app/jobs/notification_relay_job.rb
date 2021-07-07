class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    # Do something later
    html = ApplicationController.render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}, formats: [:html]
    ApplicationCable.server.broadcast "notifications: #{notification.recipient_id}", html: html
  end
end
