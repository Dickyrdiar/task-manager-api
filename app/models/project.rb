class Project < ApplicationRecord
    
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
    has_many :user
    has_many :project_members
    has_one :owner
    
    # invitation relation 
    has_many :invitations

    # devise invitation
    attr_reader :raw_invitation_token

    # mount_uploaders :image, ImageUploader
end
