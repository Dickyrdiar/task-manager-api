class Group < ApplicationRecord
    # uuid 
		validates :name, presence: true 
		validates :desc, presence: true

    # database relation 
    has_many :projects
    has_many :invitations, dependent: :destroy
    has_many :conversations
    # has_many :users, through: :invitations
    belongs_to :user
    # has_many :users

    extend FriendlyId
    friendly_id :name, use: :slugged

    has_one_attached :image
end
