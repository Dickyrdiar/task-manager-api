
class Project < ApplicationRecord

    # uuid 
    before_create :set_uuid 
    def set_uuid 
        self.id = SecureRandom.uuid 
    end

    searchkick word_start: [:name]
    def search_data 
        {
            name: name
        }
    end 

    # validates 
    validates_presence_of :name, :desc, :date_begining

    # database relation 
    has_many :messages, dependent: :destroy  
    belongs_to :group, optional: true 
    
    has_many :project_invites, dependent: :destroy
    has_many :users, through: :project_members
    belongs_to :user, optional: true
    
    # invitation relation 
    has_many :invitations

    extend FriendlyId
    friendly_id :name, use: :slugged

    # devise invitation
    attr_reader :raw_invitation_token

    # mount_uploaders :image, ImageUploader
end
