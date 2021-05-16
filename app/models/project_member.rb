class ProjectMember < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :project, optional: true
  belongs_to :sender, :class_name => 'User', optional: true
  belongs_to :recipient, :class_name => 'User', optional: true 

  before_create :generate_token
  before_save :check_user_existance

  private  

  def generate_token 
    self.token = Digest::SHA1.hexdigest([self.project_id, Time.now, rand].join)
  end

  def check_user_existance
    existing_user = User.find_by(recipient_id)
    if existing_user
      errors.add :uer_id, 'is already a member' 
    else  
      recipient_id
    end 
  end 
end
