require 'searchkick'

class Project < ApplicationRecord
    searchkick
    
    # uuid 
    before_create :set_uuid 
    def set_uuid 
        self.id = SecureRandom.uuid 
    end
   
    # validates 
    validates_presence_of :name, :desc, :date_begining

    # database relation 
    has_many :messages, dependent: :destroy  
    belongs_to :group, optional: true 
    belongs_to :user
    belongs_to :owner, :class_name => "User"
    
    # invitation relation 
    has_many :invitations

    # devise invitation
    attr_reader :raw_invitation_token
end
