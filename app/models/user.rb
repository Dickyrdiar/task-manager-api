class User < ApplicationRecord
  before_create :set_uuid 
  def set_uuid 
    self.id = SecureRandom.uuid 
  end

  # database relation
  has_many :groups, through: :messages
  has_many :messages

  has_many :invitations, :class_name => "Invite"
  has_many :sent 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
