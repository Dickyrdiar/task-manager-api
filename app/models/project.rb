class Project < ApplicationRecord
    searchkick word_start: [:name]
    def search_data 
        {
            name: name
        }
    end 

    # validates 
    validates_presence_of :name, :desc, :date_begining

    # database relation 
    # has_many :messages, dependent: :destroy  
    has_many :project_invites, dependent: :destroy
    has_many :users
    has_many :invitations
    has_many :todolists
    has_many :messages

    belongs_to :group, optional: true 
    belongs_to :user, optional: true

    extend FriendlyId
    friendly_id :name, use: :slugged

    # devise invitation
    attr_reader :raw_invitation_token

    # mount_uploaders :image, ImageUploader
    has_one_attached :image

    def unread_messages_count(current_user)
        self.messages.where("user_id != ? AND read = ?", current_user.id, false)
    end 


end
