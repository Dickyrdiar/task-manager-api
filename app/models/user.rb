class User < ApplicationRecord
  before_create :set_uuid 
  def set_uuid 
    self.id = SecureRandom.uuid 
  end

  # database relation
  has_many :groups, through: :messages
  has_many :messages

  has_many :invitations, :class_name => "Invite", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
