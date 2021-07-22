class DirectMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :user, optional: true

  # validates_presence_of :text
  after_create_commit { DirectMessageJob.perform_later(self) }

  def direct_message_time
    created_at.strftime("%v")
  end 
end
