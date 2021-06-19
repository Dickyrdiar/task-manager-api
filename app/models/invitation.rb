class Invitation < ApplicationRecord
    # database relation 
    belongs_to :group, optional: true 
    belongs_to :sender, :class_name => 'User', optional: true 
    belongs_to :recipient, :class_name => 'User', optional: true

    before_create :generate_token 
    before_save :check_user_existance 

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    attr_accessor :recipient_email 

    def sender_name
        sender.user_name 
    end 

    def sender_email
        sender.email 
    end 

    private

    def generate_token
       self.token = Digest::SHA1.hexdigest([self.group_id, Time.now, rand].join)
    end 

    def check_user_existance 
        existing_user = User.find_by(recipient_id)
        if existing_user
            p 'if masuk'
            errors.add :recipient_id, 'is already a member'
        else 
            email
        end 
    end 

    def invite
        SendInvitationsJob.perform_later(id) 
    end 
end
