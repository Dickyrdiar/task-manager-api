class Message < ApplicationRecord
    before_create :set_uuid  
    def set_uuid
        self.id = SecureRandom.uuid  
    end 

    # database relation 
   belongs_to :project
   belongs_to :sender, class_name: :User, foreign_key: 'sender_id'

    # testing 
    validates_presence_of :text
end
