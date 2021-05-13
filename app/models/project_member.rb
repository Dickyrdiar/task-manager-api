class ProjectMember < ApplicationRecord
  belongs_to :user, :class_name => 'User', optional: true
  belongs_to :project

  before_create :generate_token
  # before_save :check_user_existance

  private  

  def generate_token 
    self.token = Digest::SHA1.hexdigest([self.project_id, Time.now, rand].join)
  end

  def check_user_existance
    exsiting_user = User.find_by(params[:user_id])
    if existing_user
      errors.add :uer_id, 'is already a member' 
    else  
      user_id
    end 
  end 
end
