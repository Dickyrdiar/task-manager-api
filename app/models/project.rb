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
    belongs_to :user, class_name: "User", optional: true
    has_many :members, through: :project_members 
    has_many :project_members
    
    # invitation relation 
    has_many :invitations

    extend FriendlyId
    friendly_id :name, use: :slugged

    # devise invitation
    attr_reader :raw_invitation_token

    # mount_uploaders :image, ImageUploader
end
