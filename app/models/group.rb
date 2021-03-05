class Group < ApplicationRecord
    # uuid 
    before_create :set_uuid
    def set_uuid
        self.id  = SecureRandom.uuid  
    end 

    # validates 
    validates_presence_of :name, :desc

    # database relation 
    belongs_to :users
end
