class User < ApplicationRecord
  before_create :set_uuid 
  def set_uuid 
    self.id = SecureRandom.uuid 
  end

  has_many :messages
  attr_accessor :name, :desc, :owner_id

  # has_many :group_invitations, class_name: "GroupInvitation", foreign_key: "recipient_id"
  # has_many :sent_invites, class_name: "GroupInvitation", foreign_key: "sender_id"   
  has_many :group_invitations, :class_name => "GroupInvitation", :foreign_key => "recipient_id"
  has_many :sent_invites, class_name: "GroupInvitations", :foreign_key => "sender_id" 

  has_many :project_members, dependent: :destroy, :class_name => 'ProjectMembers', :foreign_key => 'recipient_id'
  has_many :projects, through: :project_members

  has_many :notifications, as: :recipient

  # omniauth 
  def self.from_omniauth 
    where(provider: auth.provider, uid: auth.udi).first_or_create do |user| 
      user.provider = auth.provider 
      user.uid = auth.uid 
      user.email = auth.info.email 
      user.password = Devise.friendly_token[0, 20]
    end 
  end 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         :omniauth_providers => [:google_oauth2]
end
