class Invitation < ApplicationRecord
    # devise invitation
    before_create :set_uuid  
    def set_uuid
        self.id = SecureRandom.uuid  
    end 

    belongs_to :project 
    belongs_to :user
    after_save :email_invite_if_no_user
    
end
