class Message < ApplicationRecord
    # uuid 
    before_create :set_uuid 
    def set_uuid 
        self.id = SecureRandom.uuid 
    end 

    # database relation 
    belongs_to :users, optional: true 
    belongs_to :projects
end
