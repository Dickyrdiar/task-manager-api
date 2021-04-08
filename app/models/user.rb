class User < ApplicationRecord
  before_create :set_uuid 
  def set_uuid 
    self.id = SecureRandom.uuid 
  end

  # database relation
  has_many :groups
  has_many :messages
  has_many :projects
 
  # invitation relation 
  has_many :invitations, :class_name => "Invitation", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invitation", :foreign_key => 'sender_id'

  has_many :groupinvitations, :class_name => "Groupinvitation", :foreign_key => 'recipient_id'
  has_many :sent_groupinvitations, :class_name => "Groupinvitation", :foreign_key => 'sender_id'


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
