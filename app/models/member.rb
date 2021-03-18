class Member < ApplicationRecord
    before_create :set_uuid
    def set_uuid
        self.id  = SecureRandom.uuid  
    end 

    belongs_to :user 
    belongs_to :project

    def set_user_id
        self.user = User.invite(email: emal) 
    end 
end
