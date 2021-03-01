class Project < ApplicationRecord
    # uuid 
    before_create :set_uuid 
    def set_uuid 
        self.id = SecureRandom.uuid 
    end

    # database relation 
    has_and_belongs_to_many :user, optional: true 
    has_many :messages, dependent: :destroy 
end
