class DirectMessage < ApplicationRecord
  belongs_to :user, optional: true
  after_create_commit { DirectMessageJob.perform_later(self) }
end
