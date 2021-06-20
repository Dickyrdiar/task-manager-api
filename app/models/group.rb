class Group < ApplicationRecord
    # uuid 
    validates_presence_of :name, :desc

    # database relation 
    has_many :projects
    has_many :invitations, dependent: :destroy
    # has_many :users, through: :invitations
    belongs_to :user
    # has_many :users

    extend FriendlyId
    friendly_id :name, use: :slugged

    has_one_attached :image
end
