class Project < ApplicationRecord
    # uuid 
    before_create :set_uuid 
    def set_uuid 
        self.id = SecureRandom.uuid 
    end

    # database relation 
    belongs_to :user, optional: true 
end
