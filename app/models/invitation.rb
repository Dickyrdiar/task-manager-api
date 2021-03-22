class Invitation < ApplicationRecord
    # devise invitation
    before_create :set_uuid  
    def set_uuid
        self.id = SecureRandom.uuid  
    end 

    # database relation 
    belongs_to :project, optional: true 
    belongs_to :sender, :class_name => 'User', optional: true 
    belongs_to :recipient, :class_name => 'User', optional: true

    before_create :generate_token 
    before_save :check_user_existance 

    def generate_token
        self.token = Digest::SHA1.hexdigest([self.project_id, Time.now, rand].join)
    end 

    def check_user_existance 
        recipient = User.find_by_email(email)
        if recipient
            self.recipient_id = recipient.id
        end 
    end 
end
