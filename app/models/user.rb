class User < ApplicationRecord
  attr_accessor :name, :desc, :owner_id
  attr_accessor :invitation_token

  has_many :messages
  has_many :projects, through: :project_invitations
  has_many :notifications, as: :recipient
  has_many :invitations, :class_name => "Invitations", :foreign_key => "recipient_id "
  has_many :sent_invites, :class_name => "Invitations", :foreign_key => "sender_id"
  has_many :groups

  # belongs_to :group

  # role user 
  ROLE = {
    owner: 'owner',
    members: 'members'
  }

  # omniauth 
  def self.from_omniauth 
    where(provider: auth.provider, uid: auth.udi).first_or_create do |user| 
      user.provider = auth.provider 
      user.uid = auth.uid 
      user.email = auth.info.email 
      user.username = auth.info.username
      user.password = Devise.friendly_token[0, 20]
    end 
  end 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
          omniauth_providers: [:google_oauth2, :github]
end
