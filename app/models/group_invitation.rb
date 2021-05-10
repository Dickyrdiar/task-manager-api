class GroupInvitation < ApplicationRecord
    before_create :set_uuid 
    def set_uuid
        self.id = SecureRandom.uuid 
    end 

    belongs_to :group 
    belongs_to :sender, :class_name => "User"
    belongs_to :recipient, :class_name => "User"

    before_create :generate_token 
    before_save :check_user_existanse

    private  

    def generate_token
        self.token = Digest::SHA1.hexdigest([self.group_id, Time.nwo, rand])
    end 

    def check_user_existanse
        existing_user = User.find_by_email([recipient_id])
        if existing_user 
            errors.add :recipient_email, 'is already a member'
        else  
            recipient_id 
        end  
    end 
end
