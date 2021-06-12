class Message < ApplicationRecord
    before_create :set_uuid  
    def set_uuid
        self.id = SecureRandom.uuid  
    end 

    searchkick word_start: [:text]
    def search_data
        {   
            text: text
        } 
    end 

    # database relation 
    belongs_to :project, optional: true  
    belongs_to :user, optional: true 

    # testing 
    validates_presence_of :text

    after_create_commit { MessageBroadcastJob.perform_later(self) }

    has_one_attached :image
    # validates :image, attached: true, content_type: %i[png jpg jpeg], :presence => true
end
