class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: 'User', foreign_key: "receiver_id"
  belongs_to :notifiable, polymorphic: true

  after_commit -> { NotificationRelayJob.perform_later(self) }
end
    