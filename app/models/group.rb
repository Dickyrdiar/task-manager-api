class Group < ApplicationRecord
    # uuid 
    validates_presence_of :name, :desc

    # database relation 
    has_many :projects
    has_many :invitations, dependent: :destroy
    has_many :users, through: :group_members
    belongs_to :owner, :class_name => "User"

    extend FriendlyId
    friendly_id :name, use: :slugged

    has_one_attached :image
end
