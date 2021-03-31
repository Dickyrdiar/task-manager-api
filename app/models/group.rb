class Group < ApplicationRecord
    # uuid 
    before_create :set_uuid
    def set_uuid
        self.id  = SecureRandom.uuid  
    end 

    # validates 
    # validates_presence_of :name, :desc

    # elasticsearch 
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shard: 1 } do
        mappings dynamic: 'false' do
            indexes :name  
        end  
    end 

    # database relation 
    has_many :projects
    belongs_to :user, optional: true

    has_many :invitations, :class_name => "Invitation", :foreign_key => 'recipient_id'
    has_many :sent_invites, :class_name => "Invitation", :foreign_key => 'sender_id'
end
