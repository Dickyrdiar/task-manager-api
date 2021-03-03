class User < ApplicationRecord
  # uuid 
  before_create :set_uuid 
  def set_uuid 
    self.id = SecureRandom.uuid 
  end

  # database relation 
  has_many :projects
  has_many :authentication_tokens
  has_and_belongs_to_many :messages, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
end
