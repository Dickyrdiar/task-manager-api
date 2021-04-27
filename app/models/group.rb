class Group < ApplicationRecord
    # uuid 
    before_create :set_uuid
    def set_uuid
        self.id  = SecureRandom.uuid  
    end 

    # validates 
    validates_presence_of :name, :desc

    # database relation 
    has_many :projects
    has_many :memberships
    has_many :users
    has_one :owner, class_name: 'User'

    has_many :invitations, :class_name => "Invitation", :foreign_key => 'recipient_id'
    has_many :sent_invites, :class_name => "Invitation", :foreign_key => 'sender_id'
end
