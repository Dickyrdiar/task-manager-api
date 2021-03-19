class Invitation < ApplicationRecord
    # devise invitation
    before_create :set_uuid  
    def set_uuid
        self.id = SecureRandom.uuid  
    end 

    belongs_to :project 
    belongs_to :user
    after_save :email_invite_if_no_user
    
    private  

    def email_invite_if_no_user
        unless User.find_by_email(email)
            UserMailer.send_invites(self).delifer
        end 
    end 
end
