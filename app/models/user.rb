class User < ApplicationRecord
  # uuid 
  before_create :set_uuid 
  def set_uuid 
    self.id = SecureRandom.uuid 
  end

  validates_presence_of :email, :password 

  # database relation 
  has_many :authentication_tokens
  has_and_belongs_to_many :projects
  has_many :groups  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
end
