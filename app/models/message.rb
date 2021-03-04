class Message < ApplicationRecord
    before_create :set_uuid  
    def set_uuid
        self.id = SecureRandom.uuid  
    end 

    # database relation 
    has_and_belongs_to_many :users
    belongs_to :sender

    # testing 
    validates_presence_of :text
end
