class Message < ApplicationRecord
    before_create :set_uuid  
    def set_uuid
        self.id = SecureRandom.uuid  
    end 

    # database relation 
    belongs_to :project, optional: true  
    belongs_to :user, optional: true 

    # testing 
    validates_presence_of :text

    after_create_commit { MessageBroadcastJob.perform_later(self) }

    # image model connection 
    # has_one_attached :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    # attachment :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
