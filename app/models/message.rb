class Message < ApplicationRecord
    searchkick word_start: [:text]
    def search_data
        {   
            text: text
        } 
    end 

		# validates 
		validates :text, presence: true

    # database relation 
    belongs_to :project
    belongs_to :user

    # testing 
    after_create_commit { MessageBroadcastJob.perform_later(self) }
    has_one_attached :image
   
end
