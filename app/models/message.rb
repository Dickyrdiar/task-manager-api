class Message < ApplicationRecord
    searchkick word_start: [:text]
    def search_data
        {   
            text: text
        } 
    end 

    # database relation 
    belongs_to :project
    belongs_to :user

    # testing 
    validates_presence_of :text
    after_create_commit { MessageBroadcastJob.perform_later(self) }
    has_one_attached :image
    # validates :image, attached: true, content_type: %i[png jpg jpeg], :presence => true
end
