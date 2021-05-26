class Project < ApplicationRecord
    
    # uuid 
    before_create :set_uuid 
    def set_uuid 
        self.id = SecureRandom.uuid 
    end

    include Elasticsearch::Model  
    include Elasticsearch::Model::Callbacks 

    settings index: { number_of_shards: 1 } do
        mappings dynamic: 'false' do 
            indexes :name  
            indexes :desc
        end  
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
