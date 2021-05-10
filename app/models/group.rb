class Group < ApplicationRecord
    # uuid 
    before_create :set_uuid
    def set_uuid
        self.id  = SecureRandom.uuid  
    end 

    # include AlgoliaSearchable

    # validates 
    validates_presence_of :name, :desc

    # database relation 
    has_many :projects
    has_many :group_members, dependent: :destroy
    has_many :users, through: :group_members
    belongs_to :user

    has_many :invitations, :class_name => "Invitation", :foreign_key => 'recipient_id'
    has_many :sent_invites, :class_name => "Invitation", :foreign_key => 'sender_id'
    extend FriendlyId
    friendly_id :name, use: :slugged
end
