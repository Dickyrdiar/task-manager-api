class Message < ApplicationRecord
    before_create :set_uuid  
    def set_uuid
        self.id = SecureRandom.uuid  
    end 

    # database relation 
    belongs_to :project
    belongs_to :user

    # testing 
    validates_presence_of :text

    after_create_commit { MessageBroadcastJob.perform_later(self) }
end
