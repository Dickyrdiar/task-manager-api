class Group < ApplicationRecord
    # uuid 
    before_create :set_uuid
    def set_uuid
        self.id  = SecureRandom.uuid  
    end 
    validates_presence_of :name, :desc

    # database relation 
    has_many :projects
    has_many :invitations, dependent: :destroy
    has_many :users, through: :group_members
    belongs_to :owner, :class_name => "User"

    extend FriendlyId
    friendly_id :name, use: :slugged

    has_attached_file :image, styles: { medium: "300*300>", thumb: "100*100" }, default_url: "/images/start_project3.jpg"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
