class User < ApplicationRecord
  attr_accessor :name, :desc, :owner_id
  attr_accessor :invitation_token

  has_many :messages
  has_many :projects, through: :project_invitations
  has_many :notifications, as: :recipient
  has_many :invitations, :class_name => "Invitations", :foreign_key => "recipient_id "
  has_many :sent_invites, :class_name => "Invitations", :foreign_key => "sender_id"
  has_many :groups
  has_many :direct_messages, dependent: :destroy
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
  has_many :notifications, as: :recipient

  # role user 
  ROLE = {
    owner: 'owner',
    members: 'members',
    project_manager: 'PM'
  }

  # omniauth 
  # def self.create_user_for_google(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user| 
  #     user.provider = 'google_oauth2' 
  #     user.uid = auth.uid 
  #     user.email = auth.info.email 
  #     user.username = auth.info.username
  #     user.password = Devise.friendly_token[0, 20]
  #   end 
  # end 

  def self.create_user_for_google(data)
    where(uid: data["email"]).first_or_initialize.tap do |user|
      user.provider = 'google_oauth2'
      user.uid = data["email"]
      user.email = data["email"]
      user.password=Devise.friendly_token[0,20]
      user.save! 
    end 
  end

  def unviewed_notifications_count
    Notification.for_user(self.id) 
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
          omniauth_providers: [:google_oauth2, :github]
end
